class Admin::BaseController < ApplicationController
  before_action :check_admin_permission

  def check_admin_permission
    unless logged_in? && current_user.is_admin?
      flash[:danger] = t "admin_base_denied"
      redirect_to root_url
    end
  end
end
