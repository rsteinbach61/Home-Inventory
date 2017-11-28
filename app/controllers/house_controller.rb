class HouseController < ApplicationController

  get '/houses/index' do
    erb :'/houses/index'
  end

  get '/create_house' do
    erb :'/houses/create_house'
  end

  post '/new_house' do
    if logged_in?
      @house = House.create(params)
      @house.user_id = current_user.id
      @house.save
      redirect to("/houses/show")
    else
      redirect to("/login")
    end

  end

end
