# Gems required
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'
require 'sinatra/activerecord'

# Define the connection to the database via Activerecord
set :database, {adapter: 'postgresql',
								database: 'my_reddit_db',
								host: 'localhost'}


# Define the object classes for the database
class Reddit < ActiveRecord::Base
  # has_many :comments
end 

# This is for showing the form to create new reddits
get '/newu' do
	erb :reddit_newu
end

get '/newt' do
	erb :reddit_newt
end

get '/newest' do
	@reddits = Reddit.all.order('created_at DESC')
	erb :newest
end

get '/newest/vote' do 
@reddit = Reddit.find(params[:id])
erb :newest
end



# This is for posting a new story to the database
post '/createu' do 
  Reddit.create(title: params[:title],
                        author: params[:author], 
                        url: params[:url])
  redirect '/newest'
end

post '/createt' do 
  Reddit.create(title: params[:title],
                        author: params[:author], 
                        body: params[:body])
  redirect '/newest'
end


post '/newest/:id/up_votes' do
  upvoted = Reddit.find(params[:id])
  upvoted[:up_votes] += 1
  upvoted.save
  redirect "/newest"
end

post '/newest/:id/down_votes' do
  downvoted = Reddit.find(params[:id])
  downvoted[:down_votes] += 1
  downvoted.save
  redirect "/newest"
end














