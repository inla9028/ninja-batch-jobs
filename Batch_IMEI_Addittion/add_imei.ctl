load data
into table batch_imei_addition
append
fields terminated by ";" optionally enclosed by '"'
trailing nullcols
(
  subscriber_no, 
  imei_no,
  dealer, 
  sales_agent, 
  memo_text, 
  request_process_date DATE 'DD.MM.YYYY HH24:MI', 
  request_id,
  request_user_id
)
