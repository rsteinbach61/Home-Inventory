require 'rack-flash'

class UserController < ApplicationController
  use Rack::Flash

  get '/signup' do
    if !logged_in?

      erb :'/users/new'
    else
      redirect to('/houses/index')
    end
  end

  post '/signup' do

    if params[:email].empty? || params[:password].empty?
      redirect to('/signup')
    end

    User.all.each do |user|
      if user.email == params[:email]
        flash[:login_error] = "*** Email Already In Use ***"
        redirect to('/index')
      end
    end

  @user = User.create(params)
  @house = House.create(:name => "Primary", :user_id => @user.id)
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
    else
        redirect "/signup"
    end
    erb :'/houses/index'
  end

  get '/index' do
    erb :'/index'
  end

  get '/login' do
    erb :'/users/login'
  end

  post '/login' do
    @user = User.find_by(:email => params[:email])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        erb :'/houses/index'
      else
        redirect '/login'
      end
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
