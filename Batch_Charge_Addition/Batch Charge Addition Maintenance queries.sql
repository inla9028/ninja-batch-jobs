---------------------------------------------------------------
-- First Update the Request ID to have a date for uniqueness
---------------------------------------------------------------
/*
Update batch_charge_addition a
set a.request_id = a.request_id || '-' || trunc(sysdate) || '-' || 'File-2'
where 'moul00.18.03.2016.05' in (REQUEST_USER_ID , REQUEST_ID)
and a.record_creation_date > TRUNC(SYSDATE);

commit;

select distinct request_id
from batch_charge_addition a
where a.record_creation_date > TRUNC(SYSDATE)
and request_id like 'moul00.18.03.2016.05%'
;
*/
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all records for the specific request.--==--==--==--==--==-=--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==

SELECT a.transaction_number, a.ban_no, a.subscriber_no, a.charge_code,
       a.actv_reason_code, a.amount, a.user_bill_text, a.memo_text,
       a.effective_date, a.process_status, a.process_time,
       a.status_desc, a.record_creation_date, a.request_id, a.stream,
       a.request_user_id
  FROM batch_charge_addition a
  where 'moul00.18.03.2016.05' in (REQUEST_USER_ID , REQUEST_ID)
  and a.record_creation_date > TRUNC(SYSDATE) - 1
  --and a.process_status='PRSD_ERROR'
;
  
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the status... =--==--==--==--==--==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
  select process_status, count(*)
  FROM batch_charge_addition a
  where 'moul00.18.03.2016.05' in (REQUEST_USER_ID , REQUEST_ID) --moul00.18.03.2016.05
  and a.record_creation_date > TRUNC(SYSDATE) -1
  group by process_status;
  
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the failed records, with the (trimmed) error description    -==--==
--== This list should be saved in .xls format and sent to the requestor  -==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
  SELECT a.subscriber_no, a.charge_code,
       a.actv_reason_code, a.amount, a.user_bill_text,RTRIM(SUBSTR(A.STATUS_DESC, INSTR(A.STATUS_DESC, ':') + 1, INSTR(A.STATUS_DESC, ' [ID') - INSTR(A.STATUS_DESC, ':'))) AS "STATUS_DESC"
  FROM ninjadata.batch_charge_addition a
  WHERE 'moul00.18.03.2016.05' in (REQUEST_USER_ID , REQUEST_ID)
    AND a.process_status  = 'PRSD_ERROR'
   and a.record_creation_date > TRUNC(SYSDATE) - 3
  ORDER BY a.subscriber_no, a.status_desc;


  SELECT a.subscriber_no
       --, a.charge_code,
       --a.actv_reason_code, a.amount, a.user_bill_text
       ,RTRIM(SUBSTR(A.STATUS_DESC, INSTR(A.STATUS_DESC, ':') + 1, INSTR(A.STATUS_DESC, ' [ID') - INSTR(A.STATUS_DESC, ':'))) AS "STATUS_DESC"
  FROM ninjadata.batch_charge_addition a
  WHERE 'moul00.18.03.2016.05' in (REQUEST_USER_ID , REQUEST_ID)
    AND a.process_status  = 'PRSD_ERROR'
   and a.record_creation_date > TRUNC(SYSDATE) - 3
  ORDER BY a.subscriber_no, a.status_desc;

SELECT * FROM NINJA_JOBS WHERE EXEC_METHOD = 'batchChargeAddition';
