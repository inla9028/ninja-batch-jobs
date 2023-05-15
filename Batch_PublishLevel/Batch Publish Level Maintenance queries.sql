--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all records for the specific request.--==--==--==--==--==-=--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.transaction_number, a.subscriber_no, a.publish_level,
       a.process_status, a.process_time, a.status_desc,
       a.record_creation_date, a.request_id, a.request_user_id
  FROM batch_publishlevel_update a
  where request_id ='CKH 14.03.2016 03'
  and  a.RECORD_CREATION_DATE     > TRUNC(SYSDATE) - 10;
  
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the status... =--==--==--==--==--==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
  select process_status, count(*)
  FROM batch_publishlevel_update a
  where request_id ='CKH 14.03.2016 03'
  and  a.RECORD_CREATION_DATE     > TRUNC(SYSDATE) - 10
  group by process_status;
  
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the failed records, with the (trimmed) error description    -==--==
--== This list should be saved in .xls format and sent to the requestor  -==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==

SELECT a.subscriber_no, RTRIM(SUBSTR(A.STATUS_DESC, INSTR(A.STATUS_DESC, ':') + 1, INSTR(A.STATUS_DESC, ' [ID') - INSTR(A.STATUS_DESC, ':'))) AS "STATUS_DESC"
FROM batch_publishlevel_update a
  where request_id ='CKH 14.03.2016 03'
  and process_status='PRSD_ERROR'
  and  a.RECORD_CREATION_DATE     > TRUNC(SYSDATE) - 10
  ORDER BY a.status_desc;
  

SELECT * FROM NINJA_JOBS WHERE EXEC_METHOD = 'batchPublishLevelUpdate';

UPDATE NINJA_JOBS
SET NEXT_EXEC_TIME = SYSDATE
WHERE EXEC_METHOD = 'batchPublishLevelUpdate';



COMMIT;

