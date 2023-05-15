load data
into table salesmaker_ban_creator
append
fields terminated by ";" optionally enclosed by '"'
trailing nullcols
(
 ban,
 sm_key,
 sm_desc,
 additional_name,
 enter_time,
 request_time,
 request_id,
 process_time,
 process_status,
 status_desc
)
