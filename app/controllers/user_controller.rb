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
end
