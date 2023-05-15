--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all  records
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.transaction_number, a.ban_no, a.subscriber_no, a.discount_code,
       a.memo_text, a.process_status, a.process_time, a.status_desc,
       a.record_creation_date, a.request_id
  FROM ninjadata.batch_discount_addition a
  WHERE a.request_id     = 'moul00 23.12.2015 disc';
   -- AND a.process_status = 'PRSD_ERROR'

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the status... =--==--==--==--==--==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.process_status, COUNT(*) AS "COUNT"
  FROM ninjadata.batch_discount_addition a
  WHERE a.request_id     = 'moul00 23.12.2015 disc'
  GROUP BY a.process_status
  ORDER BY a.process_status;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the status for all requests added today... --==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.request_id, a.discount_code, a.process_status, COUNT(*) AS "COUNT"
  FROM ninjadata.batch_discount_addition a
  WHERE a.record_creation_date > TRUNC(SYSDATE)
  GROUP BY a.request_id, a.discount_code, a.process_status
  ORDER BY a.request_id, a.discount_code, a.process_status;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display records that failed, with trimmed status description
--== This list should be saved in .xls format and sent to the requestor
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc || ' [ID', ' [ID'))) AS "STATUS_DESC"
  FROM ninjadata.batch_discount_addition a
  WHERE a.request_id      = 'moul00 23.12.2015 disc'
    AND a.process_status  = 'PRSD_ERROR'
--    AND a.status_desc LIKE 'Overlapping Discounts%'
  ORDER BY a.subscriber_no;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Re-process records that failed due to Tuxedo-problems. --==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.batch_discount_addition a
  SET a.process_status = 'WAITING', a.status_desc = NULL, a.process_time = NULL
  WHERE a.request_id      = 'moul00 23.12.2015 disc'
    AND a.process_status  = 'PRSD_ERROR'
    AND (a.status_desc LIKE '%Tuxedo system exception occurred during the execution of the Tuxedo service: arGtBan00%'
      OR a.status_desc LIKE 'No Jolt connections available%'
      OR a.status_desc LIKE 'Could not retrieve fokus dates%'
    );



SELECT * FROM NINJA_JOBS WHERE EXEC_METHOD = 'batchDiscountAddition';
