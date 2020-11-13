
require 'sinatra'
require_relative 'models/article_repository'
require_relative 'models/npr'

npr = Npr.new('https://text.npr.org')

article_repository = ArticleRepository.new(npr.links)

article_repository.create_articles

p article_repository.articles

get '/' do
  @message = 'YOU ARE A HORSE'
  erb :index
end
