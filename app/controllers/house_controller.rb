class HouseController < ApplicationController

  get '/houses/houses' do
    erb :'/houses/houses'
  end

  get '/create_house' do
    erb :'/houses/create_house'
  end

  post '/new_house' do
    if logged_in?
      @house = House.create(params)
      @house.user_id = current_user
      @house.save
    else
      redirect to("/login")
    end
      redirect to("/houses/houses")
  end

end
