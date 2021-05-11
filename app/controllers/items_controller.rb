class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @items = Item.includes(:user).order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(set_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  #def show
  #  @item = Item.find(params[:id])
  #end

  private

  def set_params
    params.require(:item).permit(:item_name, :explanation, :category_id, :status_id, :delivery_fee_id, :prefecture_id,
                                 :shipment_day_id, :price, :image).merge(user_id: current_user.id)
  end
end
