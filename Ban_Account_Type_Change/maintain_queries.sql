select * from ban_acct_type_change where request_id='TJP 01.10.2015';


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all (or failed) records
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.trans_number, a.ban,
       a.enter_time, a.request_time, a.process_time, a.process_status,
       a.status_desc, a.priority,
       a.request_id, a.memo_text
  FROM ban_acct_type_change a
  WHERE a.request_id     IN ('TJP 01.10.2015')
and request_time > SYSDATE -3;




--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the process status, per stream...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT  a.process_status, COUNT(*) AS "COUNT"
FROM ban_acct_type_change a
  WHERE a.request_id IN ('TJP 01.10.2015')
  AND a.enter_time > SYSDATE-3
  GROUP BY a.process_status
  ORDER BY a.process_status;
  
  --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the process status
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.process_status, COUNT(*) AS "COUNT"
  FROM ban_acct_type_change a
  WHERE a.request_id IN ('TJP 01.10.2015')
  AND a.enter_time > SYSDATE-3
  GROUP BY a.process_status
  ORDER BY a.process_status;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the remaining records, per stream... ==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_NUMBER(a.stream) AS "STREAM", a.process_status, COUNT(*) AS "COUNT"
  FROM ban_acct_type_change a
  WHERE a.request_id IN ('TJP 01.10.2015')
    AND a.process_status = 'WAITING'
  GROUP BY a.process_status, TO_NUMBER(a.stream)
  ORDER BY TO_NUMBER(a.stream), a.process_status;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the process status, per stream, action and operation... -==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_NUMBER(a.stream) AS "STREAM", a.action_code, a.process_status, COUNT(*) AS "COUNT"
  FROM ban_acct_type_change a
  WHERE a.request_id IN ('TJP 01.10.2015')
--    AND a.enter_time > TRUNC(SYSDATE)
  GROUP BY a.process_status, a.action_code, TO_NUMBER(a.stream)
  ORDER BY TO_NUMBER(a.stream), a.action_code, a.process_status;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the process status, per operation ... =--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.action_code, a.process_status, COUNT(*) AS "COUNT"
  FROM ban_acct_type_change a
  WHERE a.request_id IN ('TJP 01.10.2015')
  AND a.enter_time > TRUNC(SYSDATE)
  GROUP BY a.action_code, a.process_status
  ORDER BY a.action_code, a.process_status;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display records that failed, with complete status description
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT *
  FROM ban_acct_type_change a
  WHERE a.request_id     IN ('TJP 01.10.2015')
    AND a.enter_time     > TRUNC(SYSDATE)
    AND a.process_status = 'PRSD_ERROR';


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display records that failed, with trimmed status description
--== This list should be returned to the sender after job is finished.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, soc, a.action_code, RTRIM(SUBSTR(A.STATUS_DESC, INSTR(A.STATUS_DESC, ':') + 1, INSTR(A.STATUS_DESC, ' [ID') - INSTR(A.STATUS_DESC, ':'))) AS "STATUS_DESC" 
  FROM ban_acct_type_change a
  WHERE a.request_id     IN ('TJP 01.10.2015')
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
      FROM ban_acct_type_change a
      WHERE a.request_id    IN ('TJP 01.10.2015')
        AND a.process_status != 'WAITING'
        AND a.process_time    > SYSDATE - (15 / 1440)
      GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
      ORDER BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
);