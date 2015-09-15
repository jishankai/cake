class SiteController < ApplicationController
  def index
    @products = Product.all
  end

  def submit
    @products = Product.all
  end

  def calculate
    @products = Product.all
  end
end
