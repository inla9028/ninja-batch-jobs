load data

CHARACTERSET UTF8

into table master_transactions
append
fields terminated by ";" optionally enclosed by '"'
trailing nullcols
(
  trans_number,
  subscriber_no,
  soc,
  action_code,
  new_soc,
  enter_time,
  request_time DATE "YYYY-MM-DD HH24:MI",
  process_time,
  process_status,
  status_desc,
  dealer_code,
  sales_agent,
  priority,
  request_id,
  memo_text,
  waive_act_fee,
  stream
)
