class StaticPagesController < ApplicationController
def home
  	@products_hot = Product.hot_product
    @products=Product.search_product(params[:search])
	flash[:warning] = t "result_search"  unless @products.any?
  end
end
