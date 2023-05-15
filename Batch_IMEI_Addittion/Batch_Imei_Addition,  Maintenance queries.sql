--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all (or failed) records
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==

SELECT a.transaction_number, a.subscriber_no, a.imei_no, a.dealer,
       a.sales_agent, a.memo_text, a.process_status, a.process_time,
       a.status_desc, a.request_process_date, a.request_id,
       a.request_user_id
  FROM batch_imei_addition a
  WHERE a.request_id     IN ('inla9028 041011')
  and a.request_user_id  IN ('inla9028')
--    AND a.enter_time     > TRUNC(SYSDATE)
   AND a.process_status = 'PRSD_ERROR'
order by a.status_desc       
  
--==--==--==--==--==--==--==--==--
--== Display the status... =--==--
--==--==--==--==--==--==--==--==--
select process_status, count(*)
FROM batch_imei_addition a
  WHERE a.request_id     IN ('inla9028 041011')
  and a.request_user_id  IN ('inla9028')
  group by process_status
  
  --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the failed records, with the (trimmed) error description    -==--==
--== This list should be saved in .xls format and sent to the requestor  -==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==

SELECT a.subscriber_no, RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc, ' [ID'))) AS "STATUS_DESC"
  FROM batch_imei_addition a
  WHERE a.request_id     IN ('inla9028 041011')
  and a.request_user_id  IN ('inla9028')
    AND a.process_status  = 'PRSD_ERROR'
  ORDER BY  a.status_desc
  
  --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Re-process records that failed due to a 'BAN in use' error. -==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE batch_imei_addition a
  SET a.process_status = 'WAITING', a.status_desc = NULL, a.process_time = NULL
  WHERE a.request_id     IN ('inla9028 041011')
  and a.request_user_id  IN ('inla9028')
    AND (a.status_desc  LIKE '%BAN%in use%'
      OR a.status_desc  LIKE 'No Jolt connections available%'
      OR a.status_desc  LIKE 'Tuxedo system exception occurred during the execution of the Tuxedo service: arGtBan00%'
    )
