class OrdersController < ApplicationController
  before_action :create_cart, only: [:create, :index]
  
  def index
    @cartitems = CartItem.showcartitems Cart.find_by(user_id: current_user.id)
  end

  def destroy
    @cartitem = CartItem.find_by id: params[:id]
    @cartitem.destroy
    redirect_to orders_path
  end

  def create
    @cart.update isStatic: false, totalprice: params[:total_price]
    redirect_to orders_path
  end

  private

  def create_cart
    if Cart.find_by(user_id: current_user.id).present?
      @cart = Cart.find_by(user_id: current_user.id)
    else
      @cart = Cart.create! user_id: current_user.id
    end
  end
end
