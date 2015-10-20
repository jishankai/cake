# required
WxPay.appid = ENV["WXPAY_APP_ID"]
WxPay.key = EVN["WXPAY_KEY"]
WxPay.mch_id = ENV["WXPAY_MCH_ID"]

# optional - configurations for RestClient timeout, etc.
WxPay.extra_rest_client_options = {timeout: 2, open_timeout: 3}
