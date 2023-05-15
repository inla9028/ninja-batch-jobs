load data
CHARACTERSET UTF8
into table hgu_tmp_clone
append
fields terminated by ";" optionally enclosed by '"'
trailing nullcols
(
 subscriber_no,
 soc_old,
 soc_new,
 request_time DATE "YYYY-MM-DD HH24:MI",
 request_id,
 memo_text
)
