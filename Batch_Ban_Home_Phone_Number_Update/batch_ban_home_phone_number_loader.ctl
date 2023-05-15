-- All manadatory fields like ban_no, bill_due_day must be specified

load data

CHARACTERSET WE8MSWIN1252

into table BATCH_BAN_HOME_PHONE_NO_UPDATE
append
fields terminated by ";" optionally enclosed by '"'
trailing nullcols
(
ban_no,
home_phone_no,
process_time,
status_desc,
request_id,
request_user_id,
process_status
)
