class Admin::OrdersController < Admin::BaseController
 # before_action :total_price, only: [:create, :index]
  
  def index
    @carts = Cart.all
    @cartitems = CartItem.cartitems_product
  end

  def show
    @cartitems = CartItem.cartitems params[:id]
  end

  def create
    @cart = Cart.find_by id: params[:id]
    if params[:key].to_i==0
    @cart.update isStatic: true
    elsif params[:key].to_i==1
    @cart.update isStatic: false
    end
    redirect_to admin_orders_path
  end

  def destroy
    @Cartitems = CartItem.where cart_id: params[:id]
    @cart = Cart.find_by id: params[:id]
    @Cartitems.destroy_all
    @cart.destroy
    redirect_to admin_orders_path
  end

  #private

  #def total_price
  #  @cartitems = CartItem.cartitems params[:id]
  #  @sum = 0;
  #  @cartitems.each do |cartitem|
  #    @sum += cartitem.price * cartitem.count
  #   end
  #end
end
