class SiteController < ApplicationController
  layout "index", :only => :index

  def index
    @products = Product.all
  end
end
