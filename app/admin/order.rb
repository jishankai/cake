# coding: utf-8
ActiveAdmin.register Order do
  menu priority: 3, label: "订单"

  actions :all, except: [:destroy]
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
  permit_params :is_paid, :is_deliveried

  index do
    selectable_column
    column :context do |order|
      @context_hash = ActiveSupport::JSON.decode(order.context);
      order.context = '';
      @context_hash.each do |k, v|
        product = Product.find(k)
        order.context+=product.name+'x'+v+' '
      end
      order.context
    end
    column :fee
    column :remark
    column :is_paid
    column :is_deliveried
    column :created_at
    actions
  end

end
