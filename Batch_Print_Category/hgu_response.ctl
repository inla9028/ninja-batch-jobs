load data
into table batch_print_category
append
fields terminated by ";" optionally enclosed by '"'
trailing nullcols
(
 trans_number,
 ban,
 print_category,
 email,
 dealer_code,
 sales_agent,
 memo_text,
 enter_time,
 request_time DATE "YYYY-MM-DD HH24:MI",
 process_time,
 process_status,
 request_id,
 status_desc
)
