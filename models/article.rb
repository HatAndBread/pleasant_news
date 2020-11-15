
require 'nokogiri'
require 'open-uri'
require_relative 'words_list'
require_relative 'emoji'

class Article
  attr_accessor :url, :title, :body, :date, :emoji, :id
  def initialize(attributes = {})
    @id = rand(1..99999)
    @url = attributes[:url]
    @title = attributes[:title]
    @body = attributes[:body]
    @date = attributes[:date]
    @word_list = WordList.new
    @emoji = Emoji.new.emoji
    change_words(@body, true)
    change_words(@title)
  end

  def change_words(text, body = false)
    copy = text.downcase
    @word_list.list.each do |word_set|
      result = copy.match(/#{word_set[0]}/)
      if result && body
        @body.gsub!(/#{word_set[0]}/i, word_set[1])
      elsif result && !body
        @title.gsub!(/#{word_set[0]}/i, word_set[1].split.map(&:capitalize).join(' '))
      end
    end
  end
end

