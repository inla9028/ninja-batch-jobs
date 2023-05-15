/*

Update master_chg_pp_trans
set  requestor_id = requestor_id || '-1'
WHERE trim(requestor_id)     IN ('tjp 13.05.2016')
    AND enter_time     > TRUNC(SYSDATE) - 1
    and process_status = 'IN_PROGRESS';
    
    */

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all (or failed) records
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, a.new_priceplan, a.new_campaign_code,
       a.new_subscription_type, a.handle_commitment, a.effective_date,
       a.dealer, a.sales_agent, a.reason_code, a.memo_text,
       a.waive_fees, a.enter_time, a.request_time, a.process_time,
       a.process_status, a.status_desc, a.priority, trim(a.requestor_id),
       a.skip_ninja_validation, stream, dump(stream)
  FROM master_chg_pp_trans a  
          WHERE trim(a.requestor_id)     IN ('tjp 13.05.2016')--('AFD 29.12.2014')
    AND a.enter_time     > TRUNC(SYSDATE) - 10
  --AND a.process_status in ('WAITING', 'IN_PROGRESS')
  --AND a.process_status in ('PRSD_ERROR')
order by process_time      ;  


SELECT a.subscriber_no, a.new_priceplan, a.new_campaign_code,
       a.new_subscription_type, a.handle_commitment, a.effective_date,
       a.dealer, a.sales_agent, a.reason_code, a.memo_text,
       a.waive_fees, a.enter_time, a.request_time, a.process_time,
       a.process_status, a.status_desc, a.priority, trim(a.requestor_id),
       a.skip_ninja_validation, stream, dump(stream)
  FROM master_chg_pp_trans a  
          WHERE  a.enter_time     > TRUNC(SYSDATE) - 1
  AND a.process_status in ('WAITING', 'IN_PROGRESS')
order by process_time      ;  


--==--==--==--==--==--==--==--==--
--== Display the status... =--==--
--==--==--==--==--==--==--==--==--
select process_status, count(*)
FROM  master_chg_pp_trans a
  WHERE trim(a.requestor_id)     IN ('tjp 13.05.2016')
        AND a.enter_time     > TRUNC(SYSDATE) - 10
  group by process_status;  
  
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Calculate the average number of processed records per minute, for the last
--== 15 minutes...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT SUM("COUNT") AS "PROCESSED_RECORDS",
       TO_NUMBER(LTRIM(TO_CHAR(AVG("COUNT"), '9999999.999'))) AS "AVG_PER_MIN",
       TO_NUMBER(LTRIM(TO_CHAR(60 / AVG("COUNT"), '9999999.999'))) AS "AVG_SECS_PER_RECORD"
  FROM (
    SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI'), COUNT(*) AS "COUNT"
      FROM master_chg_pp_trans a
      WHERE a.requestor_id    IN ('tjp 13.05.2016')
        AND a.process_status != 'WAITING'
        AND a.process_time    > SYSDATE - (15 / 1440)
      GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
      ORDER BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
);
  
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--== Check if all records were loaded successfully and if so then ==-- 
--== run the statement to set process_status to WAITING           ==--
--== AND
--== Set the STREAM, if this job has to be run in multiple threads ==-- 
--== Default is 1 thread   
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--  

update master_chg_pp_trans a
set process_status='WAITING'
    , STREAM = DECODE ( MOD (SUBSTR (subscriber_no, 4),10) + 1,NULL, 1,MOD (SUBSTR (subscriber_no, 4),10) + 1)
WHERE trim(a.requestor_id)     IN ('tjp 13.05.2016')
    AND a.enter_time     > TRUNC(SYSDATE) - 10
and process_status='IN_PROGRESS';

commit;

--==--==--==--==--==--==--==--==--==--==--==
--== Select number of WAITING requests  -==-
--==--==--==--==--==--==--==--==--==--==--==
select * from master_chg_pp_trans a
where trim(a.requestor_id) IN ('tjp 13.05.2016')
And process_status='WAITING';


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the failed records, with the (trimmed) error description    -==--==
--== This list should be saved in .xls format and sent to the requestor  -==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==

SELECT a.subscriber_no, new_priceplan, RTRIM(SUBSTR(A.STATUS_DESC, INSTR(A.STATUS_DESC, ':') + 1, INSTR(A.STATUS_DESC, ' [ID') - INSTR(A.STATUS_DESC, ':'))) AS "STATUS_DESC"
  FROM  master_chg_pp_trans a
  WHERE trim(a.requestor_id) = ('tjp 13.05.2016')
  AND a.enter_time     > TRUNC(SYSDATE) - 10
  AND a.process_status  = 'PRSD_ERROR'
  ORDER BY  a.status_desc;


SELECT *
  FROM  master_chg_pp_trans a
  WHERE trim(a.requestor_id) = ('tjp 13.05.2016')
  AND a.enter_time     > TRUNC(SYSDATE) - 10
  --AND a.process_status  = 'PRSD_ERROR'
  ORDER BY  a.status_desc;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
-- When change rating is to a campaign then handle_commitment should always be set to 'N'.  --
-- The senders usually set it incorrect and if you missed this before the file was loaded   --
-- and job failed for all the requests then in order to re-run just run the update          --
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--

  UPDATE MASTER_CHG_PP_TRANS A
  SET 
    SKIP_NINJA_VALIDATION='Y', 
    --reason_code = 'KON2',    
    --dealer = 'KSSK',
    --NEW_CAMPAIGN_CODE = '000000000',
    --NEW_SUBSCRIPTION_TYPE = 'PSBCREG1',
    --HANDLE_COMMITMENT = 'N',
      PROCESS_STATUS='WAITING', 
      STATUS_DESC = NULL
  WHERE trim(a.requestor_id) = ('tjp 13.05.2016') --and dealer = 'KKSK'
  AND A.ENTER_TIME     > TRUNC(SYSDATE) - 10
  AND
  (
    (PROCESS_STATUS in ('PRSD_ERROR') /*AND STATUS_DESC like '%Invalid campaign code%'*/) /*OR
    PROCESS_STATUS in ('WAITING')*/
  )
  --AND NEW_CAMPAIGN_CODE = '00000000' -- 8 zeros...we get many file with one zero less
  ;
  
  commit;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==-
-- Delete loaded records if not all records from the file were loaded. --
-- Fix the file and run the load again for all the records             --
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==-
/*
delete master_chg_pp_trans a
where trim(a.requestor_id) IN ('tjp 13.05.2016')
      AND a.enter_time     > TRUNC(SYSDATE) - 10
and process_status='PRSD_ERROR';

COMMIT;
*/


-- UPDATE NINJA_JOBS TO RUN THE requests immediately.
SELECT * FROM NINJA_JOBS WHERE EXEC_METHOD = 'masterPPChanger';

-- Updating the time to run the job immediately.....
UPDATE NINJA_JOBS
SET NEXT_EXEC_TIME = SYSDATE
WHERE EXEC_METHOD = 'masterPPChanger'
--AND MACHINE_ID = 'NINJAP1Z_DEMON'
AND JOB_STATUS = 'SLEEPING'
; 

COMMIT;

select SYSDATE from dual;
