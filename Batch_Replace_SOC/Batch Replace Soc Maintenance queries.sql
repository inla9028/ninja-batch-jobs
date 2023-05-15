

Select * From  ninjateam.hgu_tmp_replace;


--select * from hgu_tmp_replace

/*Execute the procedure...*/

BEGIN 
  NINJATEAM.MW_PROCS.LOAD_MASTER_TRANSACTIONS;
  --COMMIT; 
END; 


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all (or failed) records
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.trans_number, a.subscriber_no, a.soc, a.action_code, a.new_soc,
       a.enter_time, a.request_time, a.process_time, a.process_status,
       a.status_desc, a.dealer_code, a.sales_agent, a.priority,
       a.request_id, a.memo_text, a.waive_act_fee, a.stream
  FROM ninjadata.master_transactions a
  WHERE a.request_id     IN ('haaa1352 29.02.2016')
and request_time > SYSDATE -3
--and a.enter_time     > sysdate -3
   -- and a.status_desc not like '%SOC is already on subscription!%'
    --and a.status_desc not like '%Found 1 missing soc%'
    --and a.status_desc not like '%is Not Active or Reserved - Current Status is%'
   -- and a.status_desc not like '%Soc not added, probably due to SocActionRules preventing it%'
    --and a.status_desc like '%has been changed since last retrieved%'
  --  and a.status_desc not like '%DuplicateFeaturesException: Found%'
    --and a.status_desc not like '%Found 1 illegal soc combination%'
   -- and a.status_desc not like '%SOC is not available for add to subscription!%'
        --and soc='FISDNGT'
    --and a.status_desc    LIKE '%Tuxedo service did not terminate successfully.%'
    --and a.status_desc    LIKE '%Found 1 duplicate feature%'
    order by --a.request_time desc
    a.status_desc
    ;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the process status, per stream...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_NUMBER(a.stream) AS "STREAM", a.process_status, COUNT(*) AS "COUNT"
FROM ninjadata.master_transactions a
  WHERE a.request_id IN ('haaa1352 29.02.2016')
  AND a.enter_time > SYSDATE-3
  GROUP BY a.process_status, TO_NUMBER(a.stream)
  ORDER BY TO_NUMBER(a.stream), a.process_status;
  
  --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the process status
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.process_status, COUNT(*) AS "COUNT"
  FROM ninjadata.master_transactions a
  WHERE a.request_id IN ('haaa1352 29.02.2016')
  AND a.enter_time > SYSDATE-3
  GROUP BY a.process_status
  ORDER BY a.process_status;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the remaining records, per stream... ==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_NUMBER(a.stream) AS "STREAM", a.process_status, COUNT(*) AS "COUNT"
  FROM ninjadata.master_transactions a
  WHERE a.request_id IN ('haaa1352 29.02.2016')
    AND a.process_status = 'WAITING'
  GROUP BY a.process_status, TO_NUMBER(a.stream)
  ORDER BY TO_NUMBER(a.stream), a.process_status;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the process status, per stream, action and operation... -==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_NUMBER(a.stream) AS "STREAM", a.action_code, a.process_status, COUNT(*) AS "COUNT"
  FROM ninjadata.master_transactions a
  WHERE a.request_id IN ('haaa1352 29.02.2016')
--    AND a.enter_time > TRUNC(SYSDATE)
  GROUP BY a.process_status, a.action_code, TO_NUMBER(a.stream)
  ORDER BY TO_NUMBER(a.stream), a.action_code, a.process_status;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the process status, per operation ... =--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.action_code, a.process_status, COUNT(*) AS "COUNT"
  FROM ninjadata.master_transactions a
  WHERE a.request_id IN ('haaa1352 29.02.2016')
  AND a.enter_time > TRUNC(SYSDATE)
  GROUP BY a.action_code, a.process_status
  ORDER BY a.action_code, a.process_status;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display records that failed, with complete status description
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT *
  FROM ninjadata.master_transactions a
  WHERE a.request_id     IN ('haaa1352 29.02.2016')
    AND a.enter_time     > TRUNC(SYSDATE)
    AND a.process_status = 'PRSD_ERROR';


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display records that failed, with trimmed status description
--== This list should be returned to the sender after job is finished.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, soc, a.action_code, RTRIM(SUBSTR(A.STATUS_DESC, INSTR(A.STATUS_DESC, ':') + 1, INSTR(A.STATUS_DESC, ' [ID') - INSTR(A.STATUS_DESC, ':'))) AS "STATUS_DESC" 
  FROM ninjadata.master_transactions a
  WHERE a.request_id     IN ('haaa1352 29.02.2016')
    AND a.enter_time     > TRUNC(SYSDATE)-3
    AND a.process_status = 'PRSD_ERROR'
  /*  and a.status_desc not like '%Found 1 illegal soc combination%'
    and a.status_desc not like '%SOC does not exist on subscription!%'
    and a.status_desc  not like '%Found 1 missing soc%'
    and a.status_desc not like '%is Not Active or Reserved - Current Status is%'
    and a.status_desc  not like '%Soc not added, probably due to SocActionRules preventing it%'
    and a.status_desc not like '%SOC is already on subscription!%'
    and a.status_desc not like '%DuplicateFeaturesException: Found%'
    and a.status_desc not like '%SOC is not available for add to subscription!%'*/
  ORDER BY a.action_code;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Calculate the average number of processed records per minute, for the last
--== 15 minutes...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT SUM("COUNT") AS "PROCESSED_RECORDS",
       TO_NUMBER(LTRIM(TO_CHAR(AVG("COUNT"), '9999999.999'))) AS "AVG_PER_MIN",
       TO_NUMBER(LTRIM(TO_CHAR(60 / AVG("COUNT"), '9999999.999'))) AS "AVG_SECS_PER_RECORD"
  FROM (
    SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI'), COUNT(*) AS "COUNT"
      FROM ninjadata.master_transactions a
      WHERE a.request_id    IN ('haaa1352 29.02.2016')
        AND a.process_status != 'WAITING'
        AND a.process_time    > SYSDATE - (15 / 1440)
      GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
      ORDER BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
);

--==--==--==--==--==--==--==--==--==--==--==--
-- Select all WAITING records by priority
--==--==--==--==--==--==--==--==--==--==--==--
select request_id, priority, count(*)
from master_transactions
where process_status='WAITING'
group by request_id, priority;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Set the execution time for these operations (that hasn't been run yet).
--== Scheduling records to be processed at the certain time in the future.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.master_transactions a
  SET a.request_time = TO_DATE('2008-06-37 01:30', 'YYYY-MM-DD HH24:MI')
  WHERE a.request_id         IN ('haaa1352 29.02.2016')
    AND a.process_status NOT IN ('PRSD_ERROR', 'PRSD_SUCCESS');

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Re-run all records, failed due to tuxedo or ban lock problems==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.master_transactions a
  SET a.process_status = 'WAITING', a.process_time = NULL, a.status_desc = NULL
  ,a.stream = (Select MAX(stream) from (
                                        (SELECT trim(substr(job_desc,28)) stream FROM NINJA_JOBS a WHERE EXEC_METHOD = 'masterManipulator' and job_status = 'SLEEPING' and rownum = 1
                                        union
                                        select '1' as stream from dual)
                                      )
               )
  WHERE a.request_id     IN ('haaa1352 29.02.2016')
    AND a.process_status = 'PRSD_ERROR'
    AND --(a.status_desc    LIKE '%No Jolt connections available%')
      /*OR a.status_desc    LIKE '%Could not retrieve fokus dates%'
      OR a.status_desc    LIKE '%Records have been updated since last retrieve%'
      OR a.status_desc    LIKE '%Please try accessing account again later%'
      OR a.status_desc    LIKE '%Tuxedo system exception occurred during the execution of the Tuxedo service:%'
      OR a.status_desc    LIKE '%Tuxedo service did not terminate successfully.%'
      OR a.status_desc    LIKE '%RunTime Error : java.util.ConcurrentModificationException%'*/
      a.status_desc like '%BAN%in use%'
      or a.status_desc like '%BAN%has been changed since last retrieved%'
      /*or a.status_desc like '%no.netcom.ninja.core.service.exception.DuplicateFeaturesException%'*/--)
    and enter_time > sysdate - 3;

COMMIT;    

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Spread the records (marked as 'IN_PROGRESS') on multiple streams ==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
/*UPDATE ninjadata.master_transactions a
  SET a.stream = DECODE(MOD(SUBSTR(a.subscriber_no, 4), 10) + 1, null, 1, MOD(SUBSTR(a.subscriber_no, 4), 10) + 1)
--    , a.request_time = TO_DATE('2008-03-33 01:45', 'YYYY-MM-DD HH24:MI')
  WHERE a.request_id IN ('moul00 31.08.2015 add2')
    AND a.process_status = 'WAITING';
*/

------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Set up the streams based on last digit of the Ban the subscriber resides. This will prevent the locks, if 2 streams are processing the subscriber under the same ban
------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Update ninjadata.master_transactions a
set a.stream = (Select MOD(SUBSTR(max(customer_id),9),10) + 1
                from Subscriber@fokus S1
                where Subscriber_No = a.Subscriber_No)
WHERE a.request_id     IN ('haaa1352 29.02.2016')
AND a.process_status = 'WAITING';    

commit;
    
    --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Pause all waiting requests...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.master_transactions a
  SET a.process_status = 'IN_PROGRESS'
  WHERE a.request_id     IN ('haaa1352 29.02.2016')
    AND a.process_status = 'WAITING';

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Resume all paused records / Errored records
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.master_transactions a
  SET a.process_status = 'WAITING', a.process_time = NULL, a.status_desc = NULL
      , a.action_code = 'MODIFY'
  WHERE a.request_id     IN ('haaa1352 29.02.2016')
   AND a.enter_time     > TRUNC(SYSDATE)
    AND a.process_status = 'PRSD_ERROR';

COMMIT;

/**********************************************************************
  DELETE FROM ninjadata.master_tran_feature_parms
  WHERE trans_number IN (SELECT trans_number  
                          FROM ninjadata.master_transactions a
                          WHERE a.request_id     IN ('moul00 31.08.2015 add2')
                          AND soc = 'MCTBFREE'
                          AND a.enter_time > SYSDATE-3
                          AND a.process_status = 'PRSD_ERROR');
                           
  DELETE from ninjadata.master_tran_features
  WHERE trans_number IN (SELECT trans_number  
                          FROM ninjadata.master_transactions a
                          WHERE a.request_id     IN ('moul00 31.08.2015 add2')
                          AND soc = 'MCTBFREE'
                          AND a.enter_time > SYSDATE-3
                          AND a.process_status = 'PRSD_ERROR');
  
  DELETE  
  FROM ninjadata.master_transactions a
  WHERE a.request_id     IN ('haaa1352 29.02.2016')
  AND soc = 'MCTBFREE'
  AND a.enter_time > SYSDATE-3
  AND a.process_status = 'PRSD_ERROR';


  
  COMMIT;
  ***************************************************************************/
  
-- UPDATE NINJA_JOBS TO RUN THE requests immediately.
SELECT * FROM NINJA_JOBS WHERE EXEC_METHOD = 'masterManipulator';

-- Updating the time to run the job immidiately.....
UPDATE NINJA_JOBS
SET NEXT_EXEC_TIME = SYSDATE
WHERE EXEC_METHOD = 'masterManipulator'
AND MACHINE_ID = 'NINJAP2Z_DEMON'
and job_status = 'SLEEPING'
AND job_id between 50 and 59; 

COMMIT;
