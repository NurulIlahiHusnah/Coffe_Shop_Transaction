select * from public.staff_data;
select * from public.transaction_data;

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