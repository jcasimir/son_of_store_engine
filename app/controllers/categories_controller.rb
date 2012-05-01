class CategoriesController < ApplicationController
  include ExtraCategoryMethods
  before_filter :lookup_category_and_products, :only => :show

  def index
    @categories = store_categories.all
  end

  def show
  end
end
