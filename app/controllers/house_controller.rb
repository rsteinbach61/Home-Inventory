class HouseController < ApplicationController

  get '/houses/index' do
    if logged_in?
      @user = current_user
      erb :'/houses/index'
    else
      redirect to("/login")
    end
  end

  post '/houses/index' do
    if logged_in?
      @user = current_user
      erb :'/houses/index'
    else
      redirect to("/login")
    end
  end

  get '/houses/new' do
    if logged_in?
      erb :'/houses/new'
    else
      redirect to("/login")
    end
  end

  post '/houses/new' do
    if logged_in?
      @user = current_user
      @house = House.create(params)
      @house.user_id = current_user.id
      @house.save
      erb :"/houses/show"
    else
      redirect to("/login")
    end
  end

  get '/houses/:id' do
    if logged_in?
      @house = House.all.find(params[:id])
      erb :'/houses/show'
    else
      redirect to('/login')
    end
  end

  get '/houses/:id/edit' do
    if logged_in?
      @house = House.find(params[:id])
      if @house.user_id == current_user.id
      erb :'/houses/edit'
      else
        redirect to("/houses/#{@house.id}")
      end
    else
      redirect to('/login')
    end
  end

  patch '/houses/:id' do
    @house = House.find(params[:id])
    if params[:name] == ""
      redirect to("/houses/#{@house.id}/edit")
    else
      @house.name = params[:name]
      @house.save
      redirect to("/houses/#{@house.id}")
    end
  end

  delete '/houses/:id/delete' do
    binding.pry
    @house = House.find(params[:id])
    if @house.user_id == current_user.id && @house.name != "Primary"

      @house.items.each do |item|
        item.destroy
      end
      @house.rooms.each do |room|
        room.destroy
      end
      @house.destroy
    redirect to('/houses/index')
    else
      redirect to("/houses/#{@house.id}")
    end
  end

end
