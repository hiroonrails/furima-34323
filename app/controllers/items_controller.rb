class ItemsController < ApplicationController
  def index
  end

  def new
    if user_signed_in?
      @item = Item.new
    else
      redirect_to user_session_path
    end
  end

  def create
    @item = Item.new(set_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def set_params
    params.require(:item).permit(:item_name, :explanation, :category_id, :status_id, :delivery_fee_id, :prefecture_id, :shipment_day_id, :price, :image).merge(user_id: current_user.id)
  end

end
