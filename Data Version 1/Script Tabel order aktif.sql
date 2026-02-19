create table order_active 
as
select 
	td.unit_price ,
	td.order_,
	pd.product,
	td.quantity ,
	pd.product_category,
	pd.new_product_yn,
	pd.promo_yn,
	td.transaction_date,
	td.transaction_time,
	od.sales_outlet_type,
	od.store_city,
	od.store_longitude,
	od.store_latitude,
	od.store_square_feet
from transaction_data td
left join product_data pd 
on td.product_id = pd.product_id 
left join outlet_data od 
on td.sales_outlet_id = od.sales_outlet_id 
left join staff_data sd 
on td.staff_id = sd.staff_id 
