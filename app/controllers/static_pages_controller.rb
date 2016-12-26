class StaticPagesController < ApplicationController
def home
  	@products_hot = Product.hot_product
  	@products=Product.search_product(params[:search])
	    .paginate page: params[:page], per_page: 3 
  end
end
