Rails.application.config.middleware.use OmniAuth::Builder do
  provider :wechat, ENV["WECHAT_APP_ID"], ENV["WECHAT_APP_SECRET"],
    :authorize_params => {:scope => "snsapi_base", :redirect_uri => "http://cake.aidigame.cn/site/index"}
end
