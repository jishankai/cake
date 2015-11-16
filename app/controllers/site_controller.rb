# coding: utf-8
class SiteController < ApplicationController
  def index
    if session[:uid].nil?
      if request.env['omniauth.auth'].nil?
        redirect_to '/auth/wechat'
        return
      end
      session[:uid] = request.env['omniauth.auth'][:uid]
    end
    @uid = session[:uid]

    #@uid = 'asdfgh'
    session[:uid] = @uid
    @customer = Customer.find_by wechat_id: @uid
    if @customer.nil?
      @customer = Customer.create(:wechat_id => @uid, :score=>0)
    end

    @products = Product.all.order(id: :asc)
  end

end
