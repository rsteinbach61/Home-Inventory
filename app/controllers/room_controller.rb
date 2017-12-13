class RoomController < ApplicationController

  get '/rooms/new' do
    if logged_in?
      @user = current_user
      erb :'/rooms/new'
    else
      redirect to ('/login')
    end
  end

    post '/rooms' do
      if !logged_in?
        redirect to ('/login')
      end

      #if !Room.all.empty?
        #Room.all.each do |room|

          #if room.house_id == params[:house_id].to_i && room.name == params[:room][:name]
            #redirect to("/houses/#{room.house_id}")
          #end
        #end
      #end

      @room = current_user.rooms.build(params[:room])
        if @room.save
          flash[:room_success] = "*** Room created ***"
        else
          flash[:room_failure] = "*** Room creation failed ***"
        end
      redirect to("/houses/#{@room.house_id}")
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
        @room = Room.all.find_by(id: params[:id])
        erb :'/rooms/edit'
      else
        redirect to('/login')
      end
    end

    post '/rooms/:id/edit' do
      if logged_in?
        @user = current_user
        @room = Room.find_by(id: params[:id])
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
      @room = Room.find_by(id: params[:id])
      if params[:name] == ""
        redirect to("/rooms/#{@room.id}/edit")
      else
        @room.name = params[:name]
        @room.save
        redirect to("/houses/#{@room.house_id}")
      end
    end

    delete '/rooms/:id/delete' do
      @room = Room.find_by(id: params[:id])
      if @room.house.user_id == current_user.id
        @room.items.each do |item|
          item.destroy
        end
        @room.destroy
        redirect to('/houses/index')
      else
        redirect to("/houses/#{@room.id}")
      end
    end

end
