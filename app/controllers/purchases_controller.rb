class PurchasesController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :purchase_params

  def index
    @purchase_address = PurchaseAddress.new
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
    params.require(:purchase_address).permit(:postal_code, :prefecture_id, :address_line1, :address_line2, :bldg_name, :phone_number, :item_id, :card_number, :card_cvc, :card_exp_month, :card_exp_year).merge(user_id: current_user.id)
  end

  def purchase_params
    @item = Item.find(params[:item_id])
  end

end
