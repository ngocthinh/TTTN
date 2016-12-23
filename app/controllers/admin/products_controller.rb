class Admin::ProductsController < ApplicationController
	
	def index
	  @products=Product.all.paginate page: params[:page], per_page: 5 
	end

	def new
		@category=Category.find_by id: params[:cate_id] unless  params[:cate_id].nil?
		@product = Product.new
	end

    def show
    	@product=Product.find_by id: params[:id]
    end


	def create
		@product = Product.create!(product_params)
		respond_to do |format|
      if @product.save
        format.html {redirect_to category_url(params[:product][:category_id]), notice: 'Product was successfully created.' }
        format.js   {}
        format.json {render :index, status: :created, location: @products}
      else
        format.html {render :new}
        format.json {render json: @product.errors, status: :unprocessable_entity}
      end
      end
	
	end

	def import
	  Product.import(params[:file])
	  redirect_to products_url
	end

	def destroy
		@product=Product.find_by id: params[:id]
		@product.destroy
	  respond_to do |format|
      format.html {redirect_to ponies_url}
      format.json {head :no_content}
      format.js   {render :layout => false}
    end
    end

	private

	def product_params
		params.require(:product).permit :productname, :productPrice, :productStatus,:productDescription, :rate, :upPicture, :category_id
	end

end
