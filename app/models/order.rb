# coding: utf-8
class Order < ActiveRecord::Base
  # 只有当微信支付时使用到，订单一旦确认(confirm)，即进行获取
  # {remote_ip: request.ip}
  def set_prepay_id(options={})
    return true if Rails.env.development?
    return true if is_prepay_id_valid?
    # 重新更新支付流水号
    self.pay_serial_number = "#{id}-#{Time.current.to_i}"
    unifiedorder = {
      body: "念客MissCake-订单",
      out_trade_no: pay_serial_number,
      total_fee: (total_price * 100).to_i, # 需要转换为分
      spbill_create_ip: options[:remote_ip] || '127.0.0.1',
      notify_url: wx_notify_url,
      trade_type: "JSAPI",
      nonce_str: SecureRandom.hex,
      openid: wechat_id
    }
    Rails.logger.debug("unifiedorder_params: #{unifiedorder}")
    res = WxPay::Service.invoke_unifiedorder(unifiedorder)
    if res.success?
      self.prepay_id = res["prepay_id"]
      self.pre_pay_id_expired_at = Time.current + 2.hours
      Rails.logger.debug("set prepay_id: #{self.prepay_id}")
      self.save(validate: false)
    else
      Rails.logger.debug("set prepay_id fail: #{res}")
      false
    end
  end

  # {remote_ip: request.ip}
  def get_prepay_id(options={})
    set_prepay_id(options) if !is_prepay_id_valid?
    prepay_id
  end

  def wx_notify_url
    "http://misscake.cc/pay_notify/wechat_notify"
  end

  # 总价
  def total_price
    self.fee
  end

  # 判断是否有效
  def is_prepay_id_valid?
    prepay_id.present? && Time.current.to_i <= pre_pay_id_expired_at.to_i
  end
end
