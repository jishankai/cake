class SiteController < ApplicationController
  layout "index", :only => :index

  def index
    @products = Product.all
  end

  def pay
    @products = Product.all
  end

  def chart
    @products = Product.all
  end
end
