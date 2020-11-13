require 'nokogiri'
require 'open-uri'
require 'sqlite3'
require_relative 'article'

class ArticleRepository
    attr_accessor :links, :articles
    def initialize(links)
        @links = links
        @articles = []
        @db = SQLite3::Database.new('db/db.db')
    end

    def create_articles
        @links.each do |link|
            doc = Nokogiri::HTML(URI.open(link))
            @articles << Article.new({title: get_title_text(doc), body: get_body_text(doc), url: link, date: Time.now.strftime("%F")})
            write_to_db({title: get_title_text(doc), body: get_body_text(doc), url: link, date: Time.now.strftime("%F")})
        end
    end

    private

    def write_to_db(attributes = {})
        puts attributes
        @db.execute("INSERT INTO articles(title, body, original_url, date_created)
                    VALUES('#{attributes[:title]}', '#{attributes[:body]}', '#{attributes[:url]}', '#{attributes[:date]}')")
    end

    def get_title_text(doc)
        title = doc.search("h1[@class='story-title']").text
        return title
    end
    def get_body_text(doc)
        body = doc.search("div[@class='paragraphs-container']").text
        return body
    end
end