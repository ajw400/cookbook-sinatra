require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require 'nokogiri'
require 'open-uri'
require_relative 'lib/parsing'
require_relative 'lib/cookbook'    # You need to create this file!
set :bind, '0.0.0.0'
configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

csv_file  = File.join(__dir__, 'recipes.csv')
@@cookbook  = Cookbook.new(csv_file)

get '/' do
  erb :index
end

get '/list' do
  @@cookbook
  erb :list
end


get '/create' do
  erb :create
end

get '/delete' do
  erb :delete
end

get '/import' do
  erb :import
end

post '/import' do
  @@result = Parsing.call(params["ingredient"])
  erb :choose_import
end

post '/delete' do
 @@cookbook.remove_recipe(params["number"].to_i - 1)
 redirect '/'
end

post '/create' do
  @@cookbook.add_recipe(Recipe.new(params["name"], params["description"], params["time"]))
  redirect '/'
end

post '/choose_import' do
  recipe = @@result[params["choice"].to_i - 1]
  @@cookbook.add_recipe(Recipe.new(recipe[0], recipe[1], recipe[2]))
  redirect '/'
end


