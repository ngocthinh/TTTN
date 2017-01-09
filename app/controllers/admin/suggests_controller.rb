class Admin::SuggestsController < Admin::BaseController
  before_action :load_suggest, only: [:destroy, :edit, :update]

  def index
  	@suggests = Suggest.all
    @categories = Category.all
  end

  def create
     @suggest = Suggest.find_by id: params[:id]
     @product = Product.new(category_id: params[:category_id], productname: @suggest.name, productDescription: @suggest.content, upPicture: @suggest.up_picture)
      if @product.save
        @suggest.destroy
        redirect_to admin_suggests_path, 
        notice: t(".products_create_sucess")
      else
        redirect_to root_path
      end
  end

  def edit 
  end

  def update 
    if @suggest.update_attributes suggest_params
       redirect_to root_path
    else
      redirect_to :back, notice: t("edit_fail")
    end
   end

  def show
  	
  end

  def destroy
  	if @suggest.destroy
      flash[:success] = t "suggest_deleted"
    else
      flash[:danger] = t "fail_delete_suggest"
    end
    redirect_to :back
  end

  private

  def suggest_params
  	 params.require(:suggest).permit :name, :content, :up_picture
  end

  def load_suggest
  	@suggest = Suggest.find_by id: params[:id]
    return render file: Settings.page_404_url unless @suggest
  end
end
