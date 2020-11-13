require 'nokogiri'
require 'open-uri'

class Npr
  attr_reader :links
  def initialize(url)
    @url = url
    @links = []
    get_links
  end

  def get_links
    doc = Nokogiri::HTML(URI.open(@url))
    doc.search("a[@class='topic-title']").map do |element|
      @links << "#{@url}#{element['href']}"
    end
  end
end
