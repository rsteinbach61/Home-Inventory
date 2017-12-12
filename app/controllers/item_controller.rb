require 'rack-flash'

class ItemController < ApplicationController
  use Rack::Flash

  get '/items/new' do
    if logged_in?
      @user = current_user
      erb :'/items/new'
    else
      redirect to ('/login')
    end
  end

  post '/items' do
    if logged_in?
      if params[:item][:room_id]
        @item = current_user.items.build(params[:item])
        #binding.pry
        if @item.save
          flash[:item_success] = "*** Item created ***"
        else
          flash[:item_failure] = "*** Item creation failed ***"
        end
        redirect to "/rooms/#{params[:item][:room_id]}"
      else
        flash[:room_error] = "*** FIRST CREATE A ROOM ***"
        redirect to(:"/houses/#{params[:house_id]}")
      end
    else
      redirect to ('/login')
    end
  end

  get '/items/index' do
    if logged_in?
      @user = current_user
      erb :'items/index'
    else
      redirect to ('/login')
    end
  end

  get '/items/upload' do
    erb :'/items/upload'
  end

  post '/items/upload' do
    @filename = params[:file][:filename] #sets the file name to string in @filename
    file_content = params[:file][:tempfile] #saves image file into file_content
    @house = House.find(params[:house_id])
    @item = @house.items.find_by(name: params[:item])
    @item.pic_file_name = @filename
    @item.save
      File.open("./public/media/#{@filename}", 'wb')  do |file| #creates new file in /public/media, 'wb' = write bianary, must use .open it allows a block .new does not
        file.write(file_content.read) #writes the contents of file_content in a file named with the string in @filename
      end
    redirect to(:"/items/#{@item.id}")
  end

  get '/items/:id/media' do
    @item = Item.all.find(params[:id])
    erb :'items/media'
  end

  get '/items/:id' do
    if logged_in?
      @item = Item.all.find(params[:id])
      erb :'/items/show'
    else
      redirect to('/login')
    end
  end

  post '/items/:id/edit' do
    if logged_in?
      @user = current_user
      @item = Item.find(params[:id])
        if @item.user_id == current_user.id
          erb :'/items/edit'
        else
          redirect to("/items/#{@item.id}")
        end
    else
      redirect to('/login')
    end
  end

  patch '/items/:id' do
    @item = Item.find(params[:id])
    if params[:name] == ""
      redirect to("/items/#{@item.id}/edit")
    else
      @item.name = params[:name]
      @item.room_id = params[:room_id]
      @item.purchase_date = params[:purchase_date]
      @item.value = params[:value]
      @item.serial_number = params[:serial_number]
      @item.save
      redirect to("/houses/#{@item.house_id}")
    end
  end

  delete '/items/:id/delete' do
    @item = Item.find(params[:id])
    #binding.pry
    if @item.user_id == current_user.id
      @item.destroy
      redirect to("/rooms/#{@item.room_id}")
    else
      redirect to("/houses/#{@item.house_id}")
    end
  end

  #-----------------
end
