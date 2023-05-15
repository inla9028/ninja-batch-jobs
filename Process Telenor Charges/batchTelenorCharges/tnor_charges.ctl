load data
into table batch_telenor_load_tmp
append
fields terminated by ";" optionally enclosed by '"'
trailing nullcols
(
charge_number,
charge_date,
charge_time,
charge_ref,
charge_text,
charge_duration,
charge_amount,
charge_operator
)
