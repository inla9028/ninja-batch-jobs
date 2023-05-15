--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all records for the specific request.--==--==--==--==--==-=--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.transaction_number, a.subscriber_no, a.marketing_indicator,
       a.dealer_code, a.process_status, a.record_creation_date,
       a.request_time, a.process_time, a.status_desc, a.request_id,
       a.request_user_id
  FROM marketing_indicator_update a
  where a.request_id      IN ('30-01-2014');
  
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the status... =--==--==--==--==--==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
  select process_status, count(*)
  FROM marketing_indicator_update a
  where a.request_id      IN ('30-01-2014')
  group by process_status;
  
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the failed records, with the (trimmed) error description    -==--==
--== This list should be saved in .xls format and sent to the requestor  -==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
  SELECT a.subscriber_no, RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc, ' [ID'))) AS "STATUS_DESC"
  FROM ninjadata.marketing_indicator_update a
  WHERE a.request_id      IN ('30-01-2014')
    AND a.process_status  = 'PRSD_ERROR'
  ORDER BY a.subscriber_no, a.status_desc;


SELECT * FROM NINJA_JOBS WHERE EXEC_METHOD like '%marketingIndicatorUpdate%'
;

UPDATE NINJA_JOBS
SET NEXT_EXEC_TIME = SYSDATE
WHERE EXEC_METHOD = 'marketingIndicatorUpdate'
AND MACHINE_ID = 'NINJAP1Z_DEMON'
AND JOB_STATUS = 'SLEEPING'
; 

commit;