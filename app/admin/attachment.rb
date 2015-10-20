# coding: utf-8
ActiveAdmin.register Attachment do
  menu priority: 6, label: "图片"

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end

  index do
    selectable_column
    column :name do |attachment|
      image_tag(attachment.name)
    end
    column :product_id
    actions
  end
end
