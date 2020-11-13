
require 'nokogiri'
require 'open-uri'

class Article
  attr_accessor :url, :title, :body, :time
  def initialize(attributes = {})
    @url = attributes[:url]
    @title = attributes[:title]
    @body = attributes[:body]
    @time = attributes[:time]
  end

  def randomize_me; end
end

