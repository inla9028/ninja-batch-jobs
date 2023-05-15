load data
CHARACTERSET UTF8
into table batch_bans_activity
append
fields terminated by ";" optionally enclosed by '"'
trailing nullcols
(
  ban_no,
  action,
  reason_code,
  activity_date DATE "YYYY-MM-DD HH24:MI",
  memo_text,
  request_id,
  stream
)
