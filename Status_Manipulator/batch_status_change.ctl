load data
CHARACTERSET UTF8
into table NINJA_SUB_CHANGE_STATUS
append
fields terminated by ";" optionally enclosed by '"'
trailing nullcols
(
subscriber_no,
action_code,
dealer_code,
memo_text,
reason_code,
fee_waiver_code,
enter_time,
request_time DATE "YYYY-MM-DD HH24:MI",
priority,
process_time,
process_status,
status_desc,
request_reference_id,
release_ctn,
prepaid_user,
hlr_stream
)
