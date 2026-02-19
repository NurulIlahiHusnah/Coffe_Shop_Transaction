--Menampilkan Order yang aktif
create table order_active
as 
select 
	td.order_,
	td.transaction_id ,
	td.transaction_date,
	td.transaction_time ,
	td.instore_yn ,
	td.line_item_amount as revenue_product,
	pd.product,
	pd.product_category,
	pd.unit_of_measure ,
	pd.new_product_yn,
	pd.promo_yn,
	od.store_address ,
	od.store_city 
from transaction_data td
left join product_data pd 
on td.product_id = pd.product_id 
left join outlet_data od 
on td.sales_outlet_id = od.sales_outlet_id ;

-- membuat membuat table detail product dengan subquery
create table detail_product
as
select 	product,
		product_category,
		product_type ,
		promo_yn,
		sum (order_) as jumlah_order_baru,
		sum (quantity) as jumlah_quantity_baru,
		sum (unit_price) as jumlah_price_baru
from 
(
select 	pd.product,
		pd.product_category,
		pd.product_type ,
		pd.tax_exempt_yn ,
		td.quantity,
		td.unit_price,
		td.line_item_id,
		td.order_ ,
		pd.promo_yn,
		pd.new_product_yn
from product_data pd
join transaction_data td
on pd.product_id = td.product_id
) as detail
where new_product_yn = 'N'
group by 1,2,3,4
order by 1,2,3

-- gender yang paling banyak melakukan pemesanan  
create table gender
as
select 	cd.gender,
		sum(td.order_) as jumlah_order,
		pd.new_product_yn
from transaction_data td
inner join customer_data cd 
on cd.customer_id =td.customer_id
inner join product_data pd 
on  td.product_id =pd.product_id 
group by 1,3
order by 2 desc

drop table top_produc 

-- membuat tabel top staff
create table top_staff as
select 
	td.order_,
	td.line_item_amount,
	sd.nama_staff,
	sd.start_date,
	sd. position
from transaction_data td 
left join staff_data sd
on td.staff_id =sd.staff_id 
