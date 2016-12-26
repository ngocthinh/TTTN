class ProductsController < ApplicationController
	
	def index  
	  @products=Product.search_product(params[:search])
	    .paginate page: params[:page], per_page: 5 
	end

    def show
    	@product=Product.find_by id: params[:id]
    end


	private

	def product_params
		params.require(:product).permit :productname, :productPrice, :productStatus,:productDescription, :rate, :upPicture, :category_id
	end

end
