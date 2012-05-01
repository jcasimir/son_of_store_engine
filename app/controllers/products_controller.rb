class ProductsController < ApplicationController
  include ExtraProductMethods
  before_filter :lookup_product, :only => :show
  before_filter :store_enabled
  # default_scope

  def index
    if params[:filtered].present?
      @products = active_store_products.where(
        if Rails.env.production?
          ["title ILIKE ?", "%#{params[:filtered]}%"]
      else
        ["title LIKE ?", "%#{params[:filtered]}%"]
      end
      ).page(params[:page]).per(9)
    else
      @products = active_store_products.page(params[:page]).per(9)
      @line_item = LineItem.new
    end
  end

  def show
  end

end
