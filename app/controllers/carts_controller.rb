class CartsController < ApplicationController
  before_action :logged_in_user, only: :show
  before_action :check_admin, only: :show
  before_action :set_products, only: [:index, :show]
  before_action :create_cart, only: :show

  def new
    session[:cart]=session[:cart] ||= Hash.new
    @products = Product.find_by id: params[:product_id]
    @comments = @products.comments
    @rates = Rate.find_by(product_id: @products.id, user_id: current_user.id) unless current_user.nil?
  end

  def create
    id = params[:product_id]
    count = params[:count] 
    @cart = session[:cart]
    @cart[id] = @cart[id] ? (@cart[id].to_i + count.to_i) : count.to_i
    redirect_to action: :index
  end


  def index
    
  end

  def destroy
    session[:cart].delete params[:id]
    redirect_to action: :index
  end

  def show
    @products.each do |product, count|
      @cartitem = CartItem.find_by(product_id: product.id, cart_id: @cart.id)
      if @cartitem
        count +=  @cartitem.count
        @cartitem.update(count: count)
      else
        @addcart = CartItem.create! price: product.
        productPrice, cart_id: @cart.id, product_id: product.id, count: count
      end
    end
    redirect_to orders_path
  end
  
  private
  
  def set_products 
    @cart = session[:cart] ? session[:cart] : Hash.new
    @products = @cart.map {|id, count| [Product.find_by(id: id), count]}
  end

  def create_cart
    if Cart.find_by(user_id: current_user.id).present?
     @cart = Cart.find_by(user_id: current_user.id)
    else
     @cart = Cart.create! user_id: current_user.id
    end
  end

  def logged_in_user
    unless logged_in? 
      store_location
      flash[:danger] = t "check_log_in"
      redirect_to login_url
    end
  end
  def check_admin
    if current_user.is_admin?
      flash[:danger] = t "you_are_admin"
      redirect_to root_path
    end
  end
end
