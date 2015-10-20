Rails.application.config.middleware.use OmniAuth::Builder do
  provider :wechat, ENV["WECHAT_APPID"], ENV["WECHAT_APP_SECRET"],
    :authorize_params => {:scope => "snsapi_base"}
end
