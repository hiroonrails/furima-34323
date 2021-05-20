class PurchasesController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @purchase_address = PurchaseAddress.new
    @item = Item.find(params[:item_id])
  end

  def create
    @purchase_address = PurchaseAddress.new(payment_params)
    if @purchase_address.valid?
      @purchase_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private
  def payment_params
    params.require(:purchase_address).permit(:postal_code, :prefecture_id, :address_line1, :address_line2, :bldg_name, :phone_number, :item_id).merge(user_id: current_user.id)
  end

end
