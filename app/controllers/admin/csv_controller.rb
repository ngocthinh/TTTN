class Admin::CsvController < Admin::BaseController
  def create
  	Product.import(params[:file])
	redirect_to admin_products_url, notice: t("product_imported")
  end
end
