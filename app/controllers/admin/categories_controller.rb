class Admin::CategoriesController < Admin::BaseController
  before_action :load_category, only: [:show, :destroy]

  def index
    @categories = Category.paginate page: params[:page], per_page: Settings.category_per_page
  end

  def new
    @category = Category.new
  end

  def show
    if @category.blank?
      @products = Settings.blank
    else
      @products = @category.products
        .paginate page: params[:page], per_page: Settings.category_per_page
    end
  end

  def create
    @category = Category.new category_params
    if @category.save
      redirect_to admin_categories_url
    else
      flash[:danger] = t "create_category_fail"
      render :index
    end
  end

  def destroy
    if @category.products.any?
      flash[:danger] = t "fail_delete_category"
    else
      @category.destroy
      flash[:success] = t "category_deleted"
    end
    redirect_to admin_categories_url
  end

  private

  def category_params
    params.require(:category).permit :name, :decription
  end

  def load_category
    @category = Category.find_by id: params[:id]
  end

end
