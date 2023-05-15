SELECT a.*
  FROM batch_sim_release a
 WHERE a.request_id = 'TCAD YYYY-MM-DD'
;

-- List waiting records
SELECT a.request_id, a.request_time, a.process_status, COUNT(1) AS "COUNT"
  FROM batch_sim_release a
 WHERE a.process_status = 'WAITING'
    OR a.request_time   > SYSDATE
GROUP BY a.request_id, a.request_time, a.process_status
ORDER BY a.request_id, a.request_time, a.process_status
;

-- List status for a certain request_id
SELECT a.request_id, a.process_status, COUNT(1) AS "COUNT"
  FROM batch_sim_release a
 WHERE a.request_id = 'TCAD YYYY-MM-DD'
GROUP BY a.request_id, a.process_status
ORDER BY a.request_id, a.process_status
;

-- List errors for a certain request id
SELECT a.sim_no, a.update_db, a.dealer,
       REPLACE (
           RTRIM (
               SUBSTR (
                   SUBSTR (a.status_desc,
                           0,
                           INSTR (a.status_desc || ' [ID', ' [ID')),
                   INSTR (
                       SUBSTR (a.status_desc,
                               0,
                               INSTR (a.status_desc || ' [ID', ' [ID')),
                       'Exception: '))), 'Exception: ', '')
           AS "STATUS_DESC"
  FROM batch_sim_release a
 WHERE a.request_id     = 'TCAD YYYY-MM-DD'
   AND a.process_status = 'PRSD_ERROR'
;

