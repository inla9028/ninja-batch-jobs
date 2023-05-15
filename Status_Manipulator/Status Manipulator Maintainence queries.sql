--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
-- Set a 'REQUEST_REFERENCE_ID' is it is null.... For Tracking
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
/*
Update NINJA_SUB_CHANGE_STATUS
Set REQUEST_REFERENCE_ID = TRUNC(SYSDATE)
  where enter_time     > TRUNC(SYSDATE)
  AND process_status in ('WAITING','IN_PROGRESS')
  AND REQUEST_REFERENCE_ID is null
;*/

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all records
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT *
  FROM NINJA_SUB_CHANGE_STATUS a
  where 
  --enter_time > TRUNC(SYSDATE) AND
  REQUEST_REFERENCE_ID like 'moul00_08032016_01%'
  AND 
  process_status  in ('WAITING','IN_PROGRESS')  ;

--==--==--==--==--==--==--==--==--
--== Display the status... =--==--
--==--==--==--==--==--==--==--==--
SELECT PROCESS_STATUS, COUNT(*) 
FROM NINJA_SUB_CHANGE_STATUS
WHERE 
--    ENTER_TIME     > TRUNC(SYSDATE) AND 
    REQUEST_REFERENCE_ID = 'moul00_08032016_01'
GROUP BY PROCESS_STATUS;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Calculate the average number of processed records per minute, for the last
--== 15 minutes...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT SUM("COUNT") AS "PROCESSED_RECORDS",
       TO_NUMBER(LTRIM(TO_CHAR(AVG("COUNT"), '9999999.999'))) AS "AVG_PER_MIN",
       TO_NUMBER(LTRIM(TO_CHAR(60 / AVG("COUNT"), '9999999.999'))) AS "AVG_SECS_PER_RECORD"
  FROM (
    SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI'), COUNT(*) AS "COUNT"
      FROM NINJA_SUB_CHANGE_STATUS a
      WHERE REQUEST_REFERENCE_ID = 'moul00_08032016_01'
        AND a.process_status != 'WAITING'
        AND a.process_time    > SYSDATE - (15 / 1440)
      GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
      ORDER BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
);

--==--==--==--==--==--==--==--==--
--Set the Streams to run in multiple threads (9)
--==--==--==--==--==--==--==--==--
update NINJA_SUB_CHANGE_STATUS a
set HLR_STREAM = DECODE ( MOD (SUBSTR (subscriber_no, 4),9) + 1,NULL, 1,MOD (SUBSTR (subscriber_no, 4),9) + 1)
WHERE REQUEST_REFERENCE_ID = 'moul00_08032016_01'
AND a.enter_time     > TRUNC(SYSDATE) - 3
and process_status in ('WAITING') ;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the process status, per stream...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_NUMBER(a.HLR_STREAM) AS "STREAM", a.process_status, COUNT(*) AS "COUNT"
FROM NINJA_SUB_CHANGE_STATUS a
  WHERE REQUEST_REFERENCE_ID = 'moul00_08032016_01'
AND a.enter_time > SYSDATE-6
  GROUP BY a.process_status, TO_NUMBER(a.HLR_STREAM)
  ORDER BY TO_NUMBER(a.HLR_STREAM), a.process_status;
  
--==--==--==--==--==--==--==--==--
--== Display the ERROR... =--==--
--==--==--==--==--==--==--==--==--
SELECT * FROM NINJA_SUB_CHANGE_STATUS 
WHERE PROCESS_STATUS='PRSD_ERROR' AND
--      ENTER_TIME     > TRUNC(SYSDATE) AND
      REQUEST_REFERENCE_ID = 'moul00_08032016_01';
  
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the failed records, with the (trimmed) error description    -==--==
--== This list should be saved in .xls format and sent to the requestor  -==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT A.SUBSCRIBER_NO, STATUS_DESC, RTRIM(SUBSTR(A.STATUS_DESC, INSTR(A.STATUS_DESC, ':') + 1, INSTR(A.STATUS_DESC, ' [ID') - INSTR(A.STATUS_DESC, ':'))) AS "STATUS_DESC"
FROM NINJA_SUB_CHANGE_STATUS A
WHERE PROCESS_STATUS  = 'PRSD_ERROR' AND 
--      ENTER_TIME     > TRUNC(SYSDATE) AND
      REQUEST_REFERENCE_ID = 'moul00_08032016_01'
AND status_desc not like '%Cancellation okay but failed to override aging for ctn%'  
ORDER BY  A.STATUS_DESC;

--==--==--==--==--==--==--==--==--
--== RERUN the failed requests =--
--==--==--==--==--==--==--==--==--

UPDATE NINJA_SUB_CHANGE_STATUS
SET PROCESS_STATUS='WAITING', HLR_STREAM = 1
WHERE PROCESS_STATUS='PRSD_ERROR' AND 
 --     ENTER_TIME     > TRUNC(SYSDATE) AND
      REQUEST_REFERENCE_ID = 'moul00_08032016_01'
      AND (status_desc  like '%Tuxedo server, containing%service is down.%'
      or status_desc  like '%Tuxedo service did not terminate successfully%'
      or status_desc  like '%Tuxedo system exception occurred%')
;
  
COMMIT;



SELECT * FROM NINJA_JOBS WHERE EXEC_METHOD = 'statusManipulator';

-- Updating the time to run the job immidiately.....
UPDATE NINJA_JOBS
SET NEXT_EXEC_TIME = SYSDATE
WHERE EXEC_METHOD = 'statusManipulator'
--AND MACHINE_ID = 'NINJAP2Z_DEMON'
AND JOB_STATUS = 'SLEEPING'
; 

COMMIT;