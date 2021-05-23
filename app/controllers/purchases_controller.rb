class PurchasesController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :purchase_params

  def index
    @purchase_address = PurchaseAddress.new
  end

  def create
    binding.pry
    @purchase_address = PurchaseAddress.new(payment_params)
    if @purchase_address.valid?
      pay_item
      @purchase_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private
  def payment_params
    params.require(:purchase_address).permit(:postal_code, :prefecture_id, :address_line1, :address_line2, :bldg_name, :phone_number).merge(user_id: current_user.id,item_id: @item.id,token: params[:token], price: @item.price)
  end

  def purchase_params
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: payment_params[:price],
        card: payment_params[:token],
        currency: 'jpy'
      )
  end

end
