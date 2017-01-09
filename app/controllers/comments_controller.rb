class CommentsController < ApplicationController
  def create
    @current_product = Product.find_by id: params[:id]
    @comment= @current_product.comments.create! content: params[:content], user_id: current_user.id
    if @comment.save
      respond_to do |format|
        format.html {redirect_to @comment}
        format.js {}
       end
    else
     render root_path
    end
  end
end
