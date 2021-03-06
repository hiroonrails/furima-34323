class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :item_params, only: [:edit, :show, :update]
  before_action :move_to_index, only: [:edit, :update]

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

  def show
  end

  def edit
  end

  def update
    if @item.update(set_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    item = Item.find(params[:id])
    if item.user_id == current_user.id
      item.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  private

  def set_params
    params.require(:item).permit(:item_name, :explanation, :category_id, :status_id, :delivery_fee_id, :prefecture_id,
                                 :shipment_day_id, :price, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    unless current_user.id == @item.user_id && @item.purchase.blank?
      redirect_to root_path
    end
  end

  def item_params
    @item = Item.find(params[:id])
  end

end
