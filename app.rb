
require 'sinatra'
require "sinatra/reloader" if development?
require 'rufus-scheduler'
require_relative 'models/article_repository'

scheduler = Rufus::Scheduler.new

article_repository = ArticleRepository.new

article_repository.retrieve_recent

get '/' do
  @message = 'YOU ARE A HORSE'
  @articles = article_repository.recent_articles
  erb :index
end

get '/articles/:id' do
  @article = article_repository.find_by_id(params['id'].to_i)[0]
  erb :article
end


scheduler.every '6h' do
  puts 'Getting new links...'
  article_repository.get_links
  puts 'Creating new articles...'
  article_repository.create_articles
  p article_repository.recent_articles
end
