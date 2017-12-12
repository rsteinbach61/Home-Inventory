require 'rack-flash'

class HouseController < ApplicationController
  use Rack::Flash

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

  post '/houses' do
    if logged_in?
      @house = current_user.houses.build(params[:house])
      if @house.save
        flash[:house_success] = "*** House created ***"
        erb :"/houses/show"
      else
        flash[:house_failure] = "*** House creation failed ***"
        redirect to("/houses/new")
      end

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

  post '/houses/:id/edit' do
    if logged_in?
      @house = House.find(params[:id])
      if @house.user_id == current_user.id && @house.name != "Primary"
      erb :'/houses/edit'
      else
        flash[:message] = "*** CAN'T EDIT PRIMARY ***"
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
      flash[:message] = "*** CAN'T DELETE PRIMARY ***"
      redirect to("/houses/#{@house.id}")
    end
  end

end
