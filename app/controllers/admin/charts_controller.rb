class Admin::ChartsController < Admin::BaseController
  def index
    @cartitems = CartItem.cartitems_product
    @cartitems_array = @cartitems.map{|a| [a.product.productname, a.count]}

    @carts = Cart.all
    @carts_array = @carts.map{|a| [a.user.name, a.totalprice]}

    @arraycart_date = @carts.group_by(&:group_by_criteria).map{|k,v| [k, v.length]}
    
    #@products_cart = CartItem.cartorder
    #@products_arraycart = @products_cart.map{|k,v| [Product.find_by(id: id), k.product.id]}
   
    @users = User.all
   
  end
end
