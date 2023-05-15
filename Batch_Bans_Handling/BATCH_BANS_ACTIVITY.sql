SELECT a.transaction_number, a.ban_no, a.action, a.reason_code,
       a.activity_date, a.memo_text, a.request_id, a.process_status,
       a.process_time, a.status_desc, a.record_creation_date, a.stream
  FROM batch_bans_activity a
  where process_status='WAITING'
  
  
  select * from batch_bans_activity where process_status='IN_PROGRESS'
  
  
  select * from batch_bans_activity where process_status='PRSD_ERROR'
  and record_creation_date > sysdate-1
  
  select process_status, count(*) 
  from batch_bans_activity
  where record_creation_date > sysdate-1
  group by process_status
  
  --update batch_bans_activity
  set process_status='WAITING'
  where process_status='IN_PROGRESS'
  and ban_no not in(
  342577202,
265383307,
259902203,
199667205,
678108200,
482880200,
451540207,
290019009,
102562303,
788199206,
175307008,
213684301,
576809008
  );
  commit;
  
  select * from batch_bans_activity where ban_no in(
    342577202,
265383307,
259902203,
199667205,
678108200,
482880200,
451540207,
290019009,
102562303,
788199206,
175307008,
213684301,
576809008
  );
