class Attachment < ActiveRecord::Base
  belongs_to :product
  mount_uploader :name, AttachmentUploader
end
