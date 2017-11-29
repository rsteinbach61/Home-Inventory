class RoomController < ApplicationController

  get '/rooms/new' do
    if logged_in?
      erb :'/rooms/new'
    else
      redirect to ('/login')
    end
  end

    post '/rooms/new' do
      if logged_in?
        @user = current_user
        @room = Room.create(params)
        @room.save
        erb :'/rooms/show'
      else
        redirect to ('/login')
      end
    end

    get '/rooms/index' do
      if logged_in?
        @user = current_user
        erb :'rooms/index'
      else
        redirect to ('/login')
      end
    end

end
