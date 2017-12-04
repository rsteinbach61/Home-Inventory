class RoomController < ApplicationController

  get '/rooms/new' do
    if logged_in?
      @user = current_user
      erb :'/rooms/new'
    else
      redirect to ('/login')
    end
  end

    post '/rooms/new' do
      if logged_in?
        @user = current_user
        @room = Room.create(params)
        redirect to("/houses/#{@room.house_id}")
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

    get '/rooms/:id' do
      if logged_in?
        @room = Room.all.find(params[:id])
        erb :'/rooms/show'
      else
        redirect to('/login')
      end
    end

    get '/rooms/:id/edit' do
      if logged_in?
        @user = current_user
        @room = Room.find(params[:id])
          #if @room.user_id == current_user.id
            erb :'/rooms/edit'
          #else
            #redirect to("/rooms/#{@room.id}")
          #end
      else
        redirect to('/login')
      end
    end

    patch '/rooms/:id' do
      @room = Room.find(params[:id])
      if params[:name] == ""
        redirect to("/rooms/#{@room.id}/edit")
      else
        @room.name = params[:name]
        @room.save
        redirect to("/houses/#{@room.house_id}")
      end
    end

    delete '/rooms/:id/delete' do
      @room = Room.find(params[:id])
      if @room.house.user_id == current_user.id
        @room.items.each do |item|
          item.destroy
        end
        @room.destroy
        redirect to('/rooms/index')
      else
        redirect to("/rooms/#{@room.id}")
      end
    end

end
