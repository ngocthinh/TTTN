class CartsController < ApplicationController
  before_action :logged_in_user, only: [:addcart]
  before_action :set_products, only: [:index, :addcart]
  before_action :create_cart, only: [:addcart]

  def new
    session[:cart]=session[:cart] ||= Hash.new
    @products = Product.find_by id: params[:product_id]
    @comments = @products.comments.paginate(page: params[:page])
    @comment = current_user.comments.build
  end

  def show
     
  end

  def create
    id = params[:product_id]
    resquest = params[:count] 
    @cart = session[:cart]
    @cart[id] = @cart[id] ? (@cart[id].to_i + resquest.to_i) : resquest.to_i
    redirect_to action: :index
  end
  
  def index

  end

  def destroy
	  session[:cart].delete params[:id]
    redirect_to action: :index
  end

  def addcart
    @products.each do |product, count|  
       @addcart = CartItem.create!(price: product.productPrice, cart_id: Cart.find_by(user_id: current_user.id).id, product_id: product.id, count: count)
    end
    redirect_to showCartItem_path
  end

  def showCartItem
    @cartItems = CartItem.where(cart_id: Cart.find_by(user_id: current_user.id))
  end

  def destroycartitem
    @cartitem = CartItem.find_by id: params[:id]
    @cartitem.destroy
    redirect_to showCartItem_path
  end

  def order
    @cart= Cart.find_by user_id: current_user.id
    @cart.update isStatic: true, totalprice: params[:total_price]
    redirect_to showCartItem_path
  end
  
  private
    def set_products 
     @cart = session[:cart] ? session[:cart] : Hash.new
     @products = @cart.map {|cart, count| [Product.find_by(id: cart[0]), count]}
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
end
