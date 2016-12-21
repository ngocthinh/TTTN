class Admin::CategorysController < Admin::BaseController

  def index
    @categorys = Category.all
  end

  def new
    @category = Category.new
  end

  def show
    @category = Category.find_by id: params[:id]
    if @category.blank?
      @products = Settings.blank
    else
      @products = @category.products.paginate page: params[:page], per_page: Settings.category_per_page
    end
  end

  def create
    @category = Category.new category_params
    if @category.save
      redirect_to admin_categorys_url
    else
      flash[:danger] = t "create_category_fail"
      render :index
    end
  end

  def destroy
    if Category.find_by(id: params[:id]).destroy
      flash[:success] = t "category_deleted"
    else
      flash[:danger] = t "fail_delete_category"
    end
    redirect_to admin_categorys_url
  end

  private

  def category_params
    params.require(:category).permit :name, :decription
  end
end
