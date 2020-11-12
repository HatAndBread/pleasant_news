# frozen_string_literal: true

require 'sinatra'
require_relative 'models/article'

get '/' do
  erb :index, locals: { message: 'I LiKE Fish n cHipS' }
end
