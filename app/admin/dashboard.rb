# coding: utf-8
ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "最近订单" do
          table_for Order.order('id desc').limit(10) do
            column("编号")  {|order| link_to(order.id, admin_order_path(order))}
            column("支付")  {|order| status_tag(order.is_paid)}
            column("配送")  {|order| status_tag(order.is_deliveried)}
            column("总价")  {|order| number_to_currency order.fee}
            column("配送时间") {|order| order.delivery_time}
          end
        end
      end

      column do
        panel "新增客人" do
          table_for Customer.order('id desc').limit(10).each do |customer|
            column("姓名")  {|customer| link_to(customer.name, admin_customer_path(customer)) }
            column("手机")  {|customer| customer.mobile }
          end
        end
      end
    end
  end # content
end
