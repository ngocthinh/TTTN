class Admin::ProductsController < Admin::BaseController

  before_action :load_product, only: [:edit, :update, :destroy]

  def index
    @products = Product.search_product(params[:search])
      .paginate page: params[:page], per_page: Settings.per_page 
  end

  def new
    @category = Category.find_by id: params[:cate_id]
    @product = Product.new
  end

  def edit 
  end

  def update 
    if @product.update_attributes product_params
       flash[:success] = t ".update_success"
       redirect_to admin_categories_path
    else
       flash[:notice] = t".update_fail"
       render :edit
    end
  end

  def show
  end

  def create
    @product = Product.new product_params
    respond_to do |format|
      if @product.save
        format.html {redirect_to admin_category_url params[:product][:category_id], 
          notice: t(".product_successfully_created")}
      else
        format.html {render :new}
      end
    end
  end

  def destroy
    respond_to do |format|
      if @product.destroy
        format.html {redirect_to products_url}
      else
        format.html {redirect_to :back}
      end
      format.js {render layout: false}
    end
  end

  private

  def load_product
    @product = Product.find_by id: params[:id]
    render file: Settings.page_404_url unless @product
  end

  def product_params
    params.require(:product)
      .permit :name, :price, :is_status, :description, 
        :rate, :up_picture, :category_id
  end
end
