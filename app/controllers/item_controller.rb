class ItemController < ApplicationController
  get '/items/new' do
    if logged_in?
      @user = current_user
      erb :'/items/new'
    else
      redirect to ('/login')
    end
  end

  post '/items/new' do
    if logged_in?
      @user = current_user
      @item = Item.create(params)
      @item.user_id = @user.id
      @item.save
      erb :'/items/show'
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
  get '/items/:id' do
    if logged_in?
      @item = Item.all.find(params[:id])
      erb :'/items/show'
    else
      redirect to('/login')
    end
  end

  get '/items/:id/edit' do
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
      @item.save
      redirect to("/items/#{@item.id}")
    end
  end
  #-----------------
end
