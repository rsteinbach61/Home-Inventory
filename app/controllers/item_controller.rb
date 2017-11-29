class ItemController < ApplicationController
  get '/items/new' do
    erb :'/items/new'
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
end
