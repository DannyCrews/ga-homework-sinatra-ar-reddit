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
   has_many :comments
end 

class Comment < ActiveRecord::Base
   belongs_to :reddits
end

# This is for showing the form to create new URL reddits
get '/newu' do
	erb :reddit_newu
end

# This is for showing the form to create new text reddits
get '/newt' do
  erb :reddit_newt
end

# This is for displaying popular reddits
get '/' do
  @reddits = Reddit.all.order('up_votes DESC')
  erb :popular
end

# This is for voting from the popular page
get '/vote' do 
  @reddit = Reddit.find(params[:id])
  erb :popular
end

# This is for displaying the newest reddits
get '/newest' do
	@reddits = Reddit.all.order('created_at DESC')
	erb :newest
end

# This is for voting from the newest page
get '/newest/vote' do 
  @reddit = Reddit.find(params[:id])
  erb :newest
end

# displays a specific subreddit
get '/:id' do
  @reddit = Reddit.find(params[:id])
  erb  :sub_reddit_name
end



# This is for posting a new URL to the database
post '/createu' do 
  Reddit.create(title: params[:title],
    author: params[:author], 
    url: params[:url])
  redirect '/newest'
end

# This is for posting new text to the database
post '/createt' do 
  Reddit.create(title: params[:title],
    author: params[:author], 
    body: params[:body])
  redirect '/newest'
end

# The following two posts are for posting up and down votes from newest
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

# The following two posts are for posting up and down votes from '/'
post '/:id/up_votes' do
  upvoted = Reddit.find(params[:id])
  upvoted[:up_votes] += 1
  upvoted.save
  redirect "/"
end

post '/:id/down_votes' do
  downvoted = Reddit.find(params[:id])
  downvoted[:down_votes] += 1
  downvoted.save
  redirect "/"
end













