
require 'nokogiri'
require 'open-uri'

class Article
  attr_accessor :url, :title, :body, :date, :id
  def initialize(attributes = {})
    @id = attributes[:id]
    @url = attributes[:url]
    @title = attributes[:title]
    @body = attributes[:body]
    @date = attributes[:date]
  end

  def randomize_title(text)
  end
end

