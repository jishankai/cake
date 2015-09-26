class SiteController < ApplicationController
  def index
    if session[:uid].nil?
      session[:uid] = request.env['omniauth.auth'][:uid]
    end
    @uid = session[:uid]

#    @uid = 'asdfgh'
    @customer = Customer.find_by wechat_id: @uid
    if @customer.nil?
      @customer = Customer.create(:wechat_id => @uid)
    end
    @is_success = 0
    if request.post?
      Customer.transaction do
        @customer.name = params[:name]
        @customer.mobile = params[:mobile]
        case params[:address_type]
        when 'school'
          @customer.school_address = params[:address].tr("\n","")
        when 'company'
          @customer.company_address = params[:address].tr("\n","")
        else
          @customer.home_address = params[:address].tr("\n","")
        end
        @customer.save
        @order = Order.create(:wechat_id => @uid)
        @order.context = params[:order]
        @order.fee = params[:total]
        @order.remark = params[:remark]
        @order.is_paid = 0
        @order.is_deliveried = 0
        @order.save

        #byebug
      end
      @is_success = 1
    end
    @products = Product.all
  end

  def order
#    if session[:uid].nil?
#      session[:uid] = request.env['omniauth.auth'][:uid]
#    end
    @uid = session[:uid]

#    @uid = 'asdfgh'
    @orders = Order.where(:wechat_id=>@uid).all
  end
end
