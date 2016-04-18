# coding: utf-8
class PayNotifiesController < ActionController::Base
  # 支付异步通知
  def weixin_notify
    result = Hash.from_xml(request.body.read)["xml"]
    Rails.logger.debug("weixin notify: #{result}")
    if WxPay::Sign.verify?(result)
      pay_serial_number = result["out_trade_no"]
      order = Order.find_by(pay_serial_number: pay_serial_number)
      order.is_paid = 1
      order.pay_logs = {
        pay_type: "weixin",
        trade_type: result[:trade_type],
        log: result
      }
      order.save(validate: false)
      # 支付成功后，减库存
      # order_hash = ActiveSupport::JSON.decode(order.context)
      # order_hash.each do |key, value|
      #   product = Product.find(key)
      #   product.inventory-=value.to_i
      #   product.save
      # end

      context_hash = ActiveSupport::JSON.decode(order.context);
      context = '';
      context_hash.each do |k, v|
        product = Product.find(k)
        context+=product.name+'x'+v+' '
      end
      template = {
        "template_id" => "wa4_6GLlV0-BSO19I8VkggzHlRz5BrxCEbVmiH9WAKY",
        "url" => "http://misscake.cc/admin",
        "topcolor" => "#FF0000",
        "data" => {
          "first" => {
            "value" => "有新的订单！",
            "color" => "#0A0A0A",
          },
          "keyword1" => {
            "value" => order.id,
            "color" => "#0080FF",
          },
          "keyword2" => {
            "value" => "#{order.customer.name} #{order.customer.mobile}",
            "color" => "#0080FF",
          },
          "keyword3" => {
            "value" => context,
            "color" => "#0080FF",
          },
          "keyword4" => {
            "value" => order.customer.home_address,
            "color" => "#0080FF",
          },
          "keyword5" => {
            "value" => order.delivery_time,
            "color" => "#0080FF",
          },
          "remark" => {
            "value" => order.remark,
            "color" => "#173177",
          }
        }
      }
      Wechat.api.template_message_send Wechat::Message.to('oyodiw-cuZDHH5wo08dVdmB4zDNo').template(template)

      Rails.logger.debug("支付成功后，减库存")
      render xml: {
               return_code: "SUCCESS"

             }.to_xml(root: 'xml', dasherize: false)
    else
      render xml: {
               return_code: "SUCCESS",
               return_msg: "签名失败"

             }.to_xml(root: 'xml', dasherize: false)
    end
  end

  # 接收 报警
  # http://www.cnblogs.com/txw1958/p/weixin-payment-solution.html
  def weixin_exception_notify
    result = Hash.from_xml(request.body.read)["xml"]
    ServiceNotify.create(service_type: "weixin", content: result)
  end
end
