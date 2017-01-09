class SuggestsController < ApplicationController
  before_action :load_suggest, only: [:destroy, :edit, :update]

  def index
  	@suggests = Suggest.suggest_user current_user.id

  end

  def new
  	@suggest = Suggest.new
  end

  def create
  	@suggest = Suggest.new(suggest_params)
  	@suggest.user_id = current_user.id
    if @suggest.save
      redirect_to suggests_path, 
      notice: t(".products_create_sucess")
    else
      redirect_to :back
    end
  end

  def edit 
  end

  def update 
    if @suggest.update_attributes suggest_params
       redirect_to suggests_path
    else
      redirect_to :back, notice: t("edit_fail")
      #flash[:error] = @product.errors.full_messages
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
