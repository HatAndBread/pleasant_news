require 'nokogiri'
require 'open-uri'
require 'sqlite3'
require_relative 'article'

class ArticleRepository
    attr_accessor :links, :recent_articles
    def initialize
        @links = []
        @url = 'https://text.npr.org'
        @db = SQLite3::Database.new('db/db.db')
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
        @links.each do |link|
            doc = Nokogiri::HTML(URI.open(link))
            write_to_db({title: get_title_text(doc), body: get_body_text(doc), url: link, date: Time.now.strftime("%F")})
        end
        retrieve_recent
    end

    def retrieve_recent
        results = @db.execute("SELECT * FROM articles ORDER BY id DESC LIMIT 10")
        @recent_articles.clear
        results.each do |result|
            @recent_articles << Article.new({title: result[1], body: result[2], url: result[3], date: result[4], id:result[0]} )
        end
    end

    def find_by_id(id)
        result = @recent_articles.select {|article| article.id == id}
        p result
        return result
    end

    private

    def write_to_db(attributes = {})
        @db.execute("INSERT INTO articles(title, body, original_url, date_created)
                    VALUES(?, ?, ?, ?)", [attributes[:title], attributes[:body], attributes[:url], attributes[:date]])
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