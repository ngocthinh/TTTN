class RatesController < ApplicationController
  before_action :point_product, only: [:create, :show]

  def create
  	if @rate
  	  @rate.update(ratePoint: params[:point])
  	else
      @rate= @current_product.rates.create! ratePoint: params[:point], user_id: current_user.id
    end
    if @rate.save
      respond_to do |format|
        format.html {redirect_to @rate}
        format.js {}
       end
    else
      render root_path
    end
  end

  def show
    
  end


  private

  def point_product
  	@current_product = Product.find_by id: params[:id]
  	@rate = Rate.find_by(product_id: @current_product.id, user_id: current_user.id)
  	@user_count = Rate.where(product_id: @current_product.id).count
  	if @user_count <=1 && @rate  
  	  @product_rate = params[:point].to_i
  	else
  	  if @rate
        @current_product.rate = (@current_product.rate * @user_count - @rate.ratePoint)/((@user_count-1).to_f.round)
        @product_rate = ((@current_product.rate * (@user_count - 1) + params[:point].to_i)/((@user_count).to_f)).round
      else
  	    @product_rate = ((@current_product.rate * @user_count  + params[:point].to_i)/((@user_count+1).to_f)).round
  	  end
    end
    @current_product.update(rate: @product_rate)
  end
end
