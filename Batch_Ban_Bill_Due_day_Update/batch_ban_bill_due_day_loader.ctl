-- All manadatory fields like ban_no, bill_due_day must be specified

load data

CHARACTERSET WE8MSWIN1252

into table BATCH_BAN_BILL_DUE_DAY_UPDATE
append
fields terminated by ";" optionally enclosed by '"'
trailing nullcols
(
ban_no,
subscriber_no,
bill_due_day,
process_status,
process_time,
status_desc,
record_creation_date,
request_id,
request_user_id
)
