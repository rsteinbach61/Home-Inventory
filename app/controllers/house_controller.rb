class HouseController < ApplicationController

  get '/houses/houses' do
    erb :'/houses/houses'
  end

  get '/create_house' do
    erb :'/houses/create_house'
  end


end
