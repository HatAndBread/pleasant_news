# frozen_string_literal: true
require 'nokogiri'
require 'open-uri'

class Article
  def initialize(original_url)
    @original_url = original_url
  end

  def retrieve_article
    doc = Nokogiri::HTML(URI.open(@original_url))
    return doc
  end

  def randomize_me; end
end

ap_news = Article.new('https://apnews.com/')

puts ap_news.retrieve_article


