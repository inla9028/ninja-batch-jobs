load data
into table SP_SUBSCRIBER_MOVE
append
fields terminated by ";" optionally enclosed by '"'
trailing nullcols
(
subscriber_no, 
exist_priceplan, 
new_subscription_type,
change_rating_reason_code, 
activation_reason_code,
memo_text, 
enter_time, 
request_time, 
process_time,
process_status, 
status_desc, 
priority, 
requestor_id,
skip_ninja_validation, 
target_ban, 
sp_user
)
