--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all records for the request... --==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, a.dealer_code, a.sales_agent, a.priceplan,
       a.campaign, a.handle_commitment, a.reason_code, a.memo_text,
       a.waive_fees, a.sub_tb_soc, a.sub_vpn_code, a.sub_cug_code,
       a.enter_time, a.process_time, a.process_status, a.processed_type,
       a.status_desc, a.requestor_id, a.request_time,
       a.process_description
  FROM ninjadata.tb_processing_trans a
  WHERE a.requestor_id   = 'MDL.18.03.2016.01'
  --  AND a.process_status = 'PRSD_ERROR'
    ;
  

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display status of all records for the request.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.process_status, COUNT(*) AS "COUNT"
FROM ninjadata.tb_processing_trans a
WHERE a.requestor_id = 'MDL.18.03.2016.01'
GROUP BY a.process_status;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the records currently marked 'IN_PROGRESS' or 'WAITING' -==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.requestor_id, a.priceplan, a.sub_tb_soc, a.sub_vpn_code, a.sub_cug_code,
       a.process_status, COUNT(*) AS "COUNT"
  FROM ninjadata.tb_processing_trans a
  WHERE a.process_status IN ('IN_PROGRESS', 'WAITING')
  GROUP BY a.requestor_id, a.priceplan, a.sub_tb_soc, a.sub_vpn_code, a.sub_cug_code, a.process_status
  ORDER BY a.requestor_id, a.priceplan, a.sub_tb_soc, a.sub_vpn_code, a.sub_cug_code, a.process_status;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display failed records, and the cause. This list should be sent to the sender after all records are processed
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, RTRIM(SUBSTR(a.status_desc, 0, INSTR(a.status_desc, ' [ID'))) AS "STATUS_DESC"
  FROM ninjadata.tb_processing_trans a
  WHERE a.requestor_id   = 'MDL.18.03.2016.01'
    AND a.process_status = 'PRSD_ERROR'
  ORDER BY a.subscriber_no, a.status_desc
;
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display failed records, and the cause; ordering by the error.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, a.priceplan, a.sub_tb_soc,
       RTRIM(SUBSTR(a.status_desc, 0, INSTR(a.status_desc, ' [ID'))) AS "STATUS_DESC"
  FROM ninjadata.tb_processing_trans a
  WHERE a.requestor_id   = 'MDL.18.03.2016.01'
    AND a.process_status = 'PRSD_ERROR'
  ORDER BY "STATUS_DESC", a.subscriber_no;
--  ORDER BY a.subscriber_no

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the time of the first- and last processed records. --==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT MIN(a.process_time) AS "FIRST_PROCESSED", MAX(a.process_time) AS "LAST_PROCESSED"
  FROM ninjadata.tb_processing_trans a
  WHERE a.requestor_id = 'MDL.18.03.2016.01';

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Re-process records that failed due to multiple BAN access. --==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.tb_processing_trans a
  SET a.process_status = 'WAITING', a.process_time = NULL,
      a.status_desc = NULL, a.processed_type = NULL
  WHERE a.requestor_id   = 'MDL.18.03.2016.01'
    AND a.process_status = 'PRSD_ERROR'
    AND (a.status_desc LIKE '%has been changed since last retrieved%'
      OR a.status_desc LIKE '%Please try accessing account again later%'
    );

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Start the processing after verification that all records were loaded properly from the file -==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.tb_processing_trans a
  SET a.process_status = 'WAITING'
  WHERE a.requestor_id   = 'MDL.18.03.2016.01'
    AND a.process_status = 'IN_PROGRESS';
    
    commit;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Stop/pause the processing the request... ==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.tb_processing_trans a
  SET a.process_status = 'IN_PROGRESS'
  WHERE a.requestor_id   = 'MDL.18.03.2016.01'
    AND a.process_status = 'WAITING';


SELECT * FROM NINJA_JOBS 

WHERE EXEC_METHOD = 'masterManipulator';


update NINJA_JOBS set next_exec_time = sysdate
 WHERE EXEC_METHOD = 'masterManipulator';

commit;

select sysdate from dual;
