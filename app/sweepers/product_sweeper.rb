class ProductSweeper < ActionController::Caching::Sweeper
  observe Product

  def after_save(product)
    expire_caches_for(product)
  end

  def after_destroy(product)
    expire_caches_for(product)
  end

  private

  def expire_caches_for(product)
    page_count = (store_products.count/ITEMS_PER_PAGE) + 1
    expire_fragment "#{product.store.to_param}_products_"
    expire_fragment "#{product.store.to_param}_admin_products_"
    (2..page_count).each do |page_number|
      expire_fragment "#{product.store.to_param}_products_#{page_number}"
      expire_fragment "#{product.store.to_param}_admin_products_#{page_number}"
    end
  end
end
