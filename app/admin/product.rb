# coding: utf-8
ActiveAdmin.register Product do
  menu priority: 4, label: "产品"
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
  permit_params :name, :price, :taste, :crafts, :efficacy, :tips, :inventory, images:[]

  index do
    selectable_column
    column :name
    column :price do |product|
      number_to_currency product.price
    end
    column :taste
    column :crafts
    column :efficacy
    column :tips
    column :inventory
    actions
  end

  show do
    attributes_table do
      row :name
      row :price do |product|
        number_to_currency product.price
      end
      # row :thumb do
      #   ul do
      #     product.thumb.each do |t|
      #       li do
      #         image_tag(t.url(:thumb))
      #       end
      #     end
      #   end
      # end
      row :taste
      row :crafts
      row :efficacy
      row :tips
      row :inventory
    end
  end

  form :html => { :multipart => true } do |f|
    f.semantic_errors

    f.inputs do
      f.input :name
      f.input :price
      f.input :taste
      f.input :crafts
      f.input :efficacy
      f.input :tips
      f.input :inventory
      f.input :thumb, as: :file, input_html: { multiple: true }
    end

    actions
  end
end
