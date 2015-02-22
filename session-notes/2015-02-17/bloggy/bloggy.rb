require './database.rb'

require 'sinatra'

enable :sessions

# get / => list of all things
# get /:username => list of all blog posts by user
# get /:username/:blog.title => specific blog post by user

# get /login => getting the login form
# post /login => authenticating a user
# post /logout => sign out / remove session for user

get "/" do
  puts "session[:user_id] = #{session[:user_id]}"
  @user = User.get(session[:user_id])

  erb :index
end

# get "/:username" do
#   user = params[:username]
#   # @blogs = User.get(user.id).blogs
#
#   erb :show_posts
# end
#
# get "/:username/:blog_title" do
#   blog_title = params[:blog_title]
#   @blog = Blog.get(title: blog_title)
#
#   erb :show_post
# end
#
get "/login" do
  @errors = session[:login_errors]
  session.delete(:login_errors)

  erb :login
end

post "/login" do
  username = params[:username]
  password = params[:password]

  puts username
  puts password

  user = User.first(username: username)
  puts user

  # Lookup how to do authentication with DataMapper

  if password == user.password
    session[:user_id] = user.id
    redirect "/"
  else
    session[:login_errors] = "Invalid password."
    redirect "/login"
  end
end
