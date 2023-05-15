load data

CHARACTERSET WE8MSWIN1252

into table hgu_tmp_trans
append
fields terminated by ";" optionally enclosed by '"'
trailing nullcols
(
 subscriber_no,
 soc,
 action,
 request_time DATE "YYYY-MM-DD HH24:MI",
 priority,
 request_id,
 memo_text,
 dealer_code,
 sales_agent
)
