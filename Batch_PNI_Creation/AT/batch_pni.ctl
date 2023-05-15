LOAD DATA
CHARACTERSET UTF8
INTO TABLE batch_pni_creation
APPEND
FIELDS TERMINATED BY ";" OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS (
  company_name,
  action_code,
  pni_type,
  member_count   "DECODE(:member_count, null, 999999999, :member_count)",
  request_id,
  process_status "DECODE(:process_status, null, 'WAITING', :process_status)",
  status_desc,
  pni_code,
  enter_time,
  request_time    DATE "YYYY-MM-DD HH24:MI",
  process_time
)
