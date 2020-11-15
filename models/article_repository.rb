

require 'nokogiri'
require 'open-uri'
require_relative 'article'

class ArticleRepository
  attr_accessor :links, :recent_articles
  def initialize
    @links = []
    @url = 'https://text.npr.org'
    @recent_articles = []
  end

  def get_links
    doc = Nokogiri::HTML(URI.open(@url))
    @links.clear
    doc.search("a[@class='topic-title']").map do |element|
      @links << "#{@url}#{element['href']}"
    end
  end

  def create_articles
    @recent_articles.clear
    @links.each do |link|
      doc = Nokogiri::HTML(URI.open(link))
      @recent_articles << Article.new({ title: get_title_text(doc), body: get_body_text(doc), url: link, date: Time.now.strftime('%F') })
    end
  end

  def find_by_id(id)
    result = @recent_articles.select { |article| article.id == id }
    p result
    result
  end

  private

  def get_title_text(doc)
    title = doc.search("h1[@class='story-title']").text
    title
  end

  def get_body_text(doc)
    body = doc.search("div[@class='paragraphs-container']").text
    body
  end
end
