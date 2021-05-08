class ItemsController < ApplicationController
  def index
  end

  def new
    if user_signed_in?
      @items = Item.new
    else
      redirect_to root_path
    end
  end

  def create

  end

end
