class PurchasesController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :purchase_params
  before_action :payment_block_logout, :payment_block_user, :payment_block_purchaser

  def index
      @purchase_address = PurchaseAddress.new
  end

  def create
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

  def payment_block_user
    if current_user.id == @item.user_id
      redirect_to root_path
    end
  end

  def payment_block_purchaser
    if @item.purchase.present?
      redirect_to root_path
    end
  end

  def payment_block_logout
    unless user_signed_in?
      redirect_to user_session_path
    end
  end

end
