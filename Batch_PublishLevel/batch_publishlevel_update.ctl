load data
into table batch_publishlevel_update
append
fields terminated by ";" optionally enclosed by '"'
trailing nullcols
(transaction_number,subscriber_no,publish_level,process_status,process_time,status_desc,record_creation_date,request_id,request_user_id)
