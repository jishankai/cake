class Product < ActiveRecord::Base
  mount_uploader :thumb, ThumbUploader
end
