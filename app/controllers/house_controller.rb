class HouseController < ApplicationController

  get '/houses/index' do
    erb :'/houses/index'
  end

  get '/houses/new' do
    erb :'/houses/new'
  end

  post '/new_house' do
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

end
