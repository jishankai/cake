class SiteController < ApplicationController
  def index
#    if session[:uid].nil?
#      session[:uid] = request.env['omniauth.auth'][:uid]
#    end
#    @uid = session[:uid]

    @uid = 'asdfgh'
    @customer = Customer.find_by wechat_id: @uid
    if @customer.nil?
      @customer = Customer.create(:wechat_id => @uid)
    end
    if request.post?
      params
    end
    @products = Product.all
  end
end
