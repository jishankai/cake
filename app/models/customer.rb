class Customer < ActiveRecord::Base
  has_many :orders, :foreign_key => 'wechat_id'
end
