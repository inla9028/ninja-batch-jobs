load data
CHARACTERSET UTF8
into table batch_socs
append
fields terminated by ";" optionally enclosed by '"'
trailing nullcols
(
  subscriber_no,
  add_socs,
  dealer_code,
  request_id,
  request_time DATE "YYYY-MM-DD HH24:MI",
  process_status  
)
