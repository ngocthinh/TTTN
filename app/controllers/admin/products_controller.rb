class Admin::ProductsController < Admin::BaseController
	
	def index
	  @products=Product.search_product(params[:search]).paginate page: params[:page], per_page: 5 
	end

	def new
		@category=Category.find_by id: params[:cate_id] unless  params[:cate_id].nil?
		@product = Product.new
	end

    def edit 
      @product = Product.find(params[:id]) 
    end

    def update 
      @product = Product.find(params[:id]) 
      if @product.update_attributes product_params
         redirect_to admin_products_path
      else
        redirect_to root_path
      end
    end

    def show
    	@product=Product.find_by id: params[:id]
    end


	def create
		@product = Product.new(product_params)
		respond_to do |format|
      if @product.save
        format.html {redirect_to admin_category_url(params[:product][:category_id]), notice: 'Product was successfully created.' }
      else
        format.html {render :new}
      end
      end
	
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
