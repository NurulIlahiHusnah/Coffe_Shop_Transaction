create table top_produc
as
select 
	td.quantity,
	td.unit_price,
	td.promo_item_yn,
	pd.product_type,
	pd.unit_of_measure,
	pd.new_product_yn 
from transaction_data td 
left join product_data pd 
on td.product_id =pd.product_id; 