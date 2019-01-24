require 'sinatra'
require 'sinatra/flash'
require 'pry'
require_relative 'models'

enable :sessions

get '/' do
  erb :landing_page
  
end


get '/signup' do
  erb (:signup)
end

post '/signup' do
  @user = User.create(
    username: params[:username],
    password: params[:password],
    name: params[:fullname],
    email: params[:email],
    dob: params[:dob],
    created_timestamp: Time.now
  )

  session[:user_id] = @user.id
  flash[:info] = 'you have signed up'
  redirect '/'
end

get '/signin' do
  erb :signin
end

post '/signin' do
  @user = User.find_by(username: params[:username])
  if (@user && @user.password == params[:password])
    session[:user_id] = @user.id
  end
  redirect '/'
end



get '/signout' do
  session[:user_id] = nil
  redirect '/'
end

get '/users/:id' do
  @user = User.find(params[:id])
  @posts = @user.posts.last(20).reverse
  
  erb :users

end

get '/posts' do
  @user = User.find_by(id: session[:user_id])
  @posts = Post.all
  erb(:posts)
end


get '/create_post' do
  @user = User.find_by(id: session[:user_id])
  if @user.nil?
    flash[:info] = "You have not been logged in"
    redirect '/'
  end

  erb (:create_post)

end

post '/create_post' do
  @user = User.find_by(id: session[:user_id])
  @post = Post.create(
    user_id: @user.id,
    subject: params[:subject],
    content: params[:content],
    username: @user.username,
    created_timestamp: Time.now
  )
  if @user.post_counter==nil
    @user.post_counter=0
  end
  @user.post_counter +=1
  @user.save
  redirect '/posts'

end

post '/delete_account' do
  @user = User.find_by(id: session[:user_id])
  @post = Post.where(user_id: @user.id)
  @post.each { |post| post.destroy}
  @user.destroy
  session[:user_id] = nil
  redirect '/'
end

post '/delete_post/:post_id' do
  @user = User.find_by(id: session[:user_id])
  @post = Post.find_by(id: params[:post_id])
  @user.post_counter -=1
  @user.save
  @post.destroy

  redirect '/posts'

end



get '/update_post/:post_id' do
  @user = User.find_by(id: session[:user_id])
  @post = Post.find_by(id: params[:post_id])
  if session[:user_id]  == @user.id
    erb (:update_post)
  else
    redirect '/posts'
  end

end



post '/update_post/:post_id' do
  @post = Post.find_by(id: params[:post_id])
  @post.update(
    subject: params[:subject],
    content: params[:content],
    updated_timestamp: Time.now
  )
  redirect 'posts'

end

