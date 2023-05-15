load data
CHARACTERSET UTF8
into table batch_replace_keep_exp_date
append
fields terminated by ";" optionally enclosed by '"'
trailing nullcols
(
 subscriber_no,
 old_soc,
 old_soc_promo,
 new_soc,
 new_soc_promo,
 dealer_code,
 sales_agent,
 memo_text,
 request_id,
 enter_time,
 request_time DATE "YYYY-MM-DD HH24:MI",
 process_time,
 process_status,
 status_desc
)
