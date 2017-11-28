class UserController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'/users/create_user'
    else
      redirect to('/houses/houses')
    end
  end

  post '/signup' do
    if params[:email].empty? || params[:password].empty?
      redirect to('/signup')
    end

  user = User.create(params)
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to('/houses/houses')
    else
        redirect "/signup"
    end
  end

  get '/login' do
    erb :'/users/login'
  end

  post '/login' do
    
  end

  get '/logout' do
    #clear session hash
      session.clear
      redirect to '/login'
  end

  post '/logout' do
    session.clear
    redirect to '/login'
  end

  #-------------------------------
end
