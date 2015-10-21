class OrdersController < ApplicationController
  def show
    @uid = session[:uid]

    @customer = Customer.find_by! wechat_id: @uid
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
    end

    @context_hash = ActiveSupport::JSON.decode(@order.context);
    @order.context = '';
    @context_hash.each do |k, v|
      product = Product.find(k)
      @order.context+=product.name+'x'+v+' '
    end

    @pay_p = {
      appId: Rails.application.secrets.app_id,
      timeStamp: Time.now.to_i.to_s,
      nonceStr: SecureRandom.hex,
      package: "prepay_id=#{@order.get_prepay_id(remote_ip: request.ip)}",
      signType: "MD5"
    }
    @pay_sign = WxPay::Sign.generate(@pay_p)
  end
end
