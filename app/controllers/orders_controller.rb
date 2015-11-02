class OrdersController < ApplicationController
  def index
    @uid = session[:uid]

    @orders = Order.joins(:customer).where( :customers => {:wechat_id=>@uid} )
    @orders.each do |value|
      #byebug
      @context_hash = ActiveSupport::JSON.decode(value.context);
      value.context = '';
      @context_hash.each do |k, v|
        product = Product.find(k)
        value.context+=product.name+'x'+v+' '
      end
    end
  end

  def create
    @uid = session[:uid]

    @customer = Customer.find_by! wechat_id: @uid
    Customer.transaction do
      @customer.name = params[:name]
      @customer.mobile = params[:mobile]
      # case params[:address_type]
      # when 'school'
      #   @customer.school_address = params[:address].tr("\n","")
      # when 'company'
      #   @customer.company_address = params[:address].tr("\n","")
      # else
      #   @customer.home_address = params[:address].tr("\n","")
      # end
      @customer.home_address = params[:address].tr("\n", "")
      @customer.save

      #@order = Order.create(:wechat_id => @uid)
      @order = @customer.orders.build()
      @order.context = params[:order]
      @order.fee = params[:total]
      @order.remark = params[:remark]
      @order.is_paid = 0
      @order.is_deliveried = 0
      @order.save
    end

    @context_hash = ActiveSupport::JSON.decode(@order.context);
    @context = '';
    @context_hash.each do |k, v|
      product = Product.find(k)
      @context+=product.name+'x'+v+' '
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

  def view
    id = params[:id]
    @order = Order.includes(:customer).find(id)

    @context_hash = ActiveSupport::JSON.decode(@order.context);
    @context = '';
    @context_hash.each do |k, v|
      product = Product.find(k)
      @context+=product.name+'x'+v+' '
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

  def del
    id = params[:id]
    Order.delete(id)

    redirect_to '/order'
  end
end
