load data
CHARACTERSET UTF8
into table batch_socs
append
fields terminated by ";" optionally enclosed by '"'
trailing nullcols
(
  ban,
  subscriber_no,
  add_socs,
  modify_socs,
  delete_socs,
  chk_priceplan,
  dealer_code,
  sales_agent,
  memo_text,
  operator_id,
  request_id,
  waive_act_fee,
  request_time DATE "YYYY-MM-DD HH24:MI"
)
