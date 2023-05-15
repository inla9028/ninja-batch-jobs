
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all records for the specific request.--==--==--==--==--==-=--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.transaction_number, a.ban_no, a.subscriber_no,
       a.adjustment_code, a.memo_text, a.user_bill_text, a.amount,
       a.process_status, a.process_time, a.status_desc,
       a.record_creation_date, a.request_id, a.stream,
       a.request_user_id, a.effective_date
  FROM ninjadata.batch_adjustment_addition a  
  WHERE a.request_id       like ('TRKA0776 29.04.2016%')
    --AND a.request_user_id IN ('tobj1039')
    AND a.process_status  = 'PRSD_ERROR'
  --  and a.status_desc like '%Voucher type ADJ is locked%'
      and a.record_creation_date > sysdate -1
  ;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the status... =--==--==--==--==--==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.process_status, COUNT(*) AS "Count"
  FROM ninjadata.batch_adjustment_addition a
  WHERE a.request_id       like ('TRKA0776 29.04.2016%')
--    AND a.request_user_id IN ('tobj1039')
    and a.record_creation_date > sysdate -1
  GROUP BY a.process_status
  ORDER BY a.process_status;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the failed records, with the (trimmed) error description    -==--==
--== This list should be saved in .xls format and sent to the requestor  -==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, a.adjustment_code, a.amount, RTRIM(SUBSTR(A.STATUS_DESC, INSTR(A.STATUS_DESC, ':') + 1, INSTR(A.STATUS_DESC, ' [ID') - INSTR(A.STATUS_DESC, ':'))) AS "STATUS_DESC"
  FROM ninjadata.batch_adjustment_addition a
  WHERE a.request_id      like ('TRKA0776 29.04.2016%')
    AND a.process_status  = 'PRSD_ERROR'
    and a.record_creation_date > sysdate -1
  ORDER BY a.status_desc;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the sum, average, maximum and minimum values that were
--== successfully processed, and display names that /even/ Marketing People
--== might, just might understand...
--== The result of the query should be sent to the sender for statistics
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT SUM(a.amount) AS "Total sum", TO_NUMBER(LTRIM(TO_CHAR(AVG(a.amount), '9999999.99'))) AS "Gj.snitt sum", 
       MAX(a.amount) AS "Høyest sum", MIN(a.amount) AS "Lavest sum"
  FROM ninjadata.batch_adjustment_addition a
  WHERE a.request_id      like ('TRKA0776 29.04.2016%')
--    AND a.request_user_id IN ('tobj1039')
    and a.process_status='PRSD_SUCCESS'
    and a.record_creation_date > sysdate -1
 ;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--== -==--==--==--==
--== Re-process records that failed due to a 'BAN in use' error or tuxedo unavailable error -==-
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--== -==--==--==--==
UPDATE ninjadata.batch_adjustment_addition a
  SET a.process_status = 'WAITING', a.status_desc = NULL, a.process_time = NULL,
      a.adjustment_code = UPPER (a.adjustment_code)
  WHERE a.request_id     like ('TRKA0776 29.04.2016%')
    AND a.process_status  = 'PRSD_ERROR'
    and a.record_creation_date > sysdate -.1
    ;
    
    commit;


--==--==--==--==--==--==--==--==--==--==--==
--== Select number of WAITING requests  -==-
--==--==--==--==--==--==--==--==--==--==--==
        
    select count(*) from batch_adjustment_addition a
    where process_Status='WAITING'
    and a.request_id       IN ('TRKA0776 29.04.2016');

-------------------------------------------------------------------------------------------------    
-- Update to IN_PROGRESS, if the adjustment code is incorrect... This is to pause the processing.
-------------------------------------------------------------------------------------------------

UPDATE ninjadata.batch_adjustment_addition a
  SET a.process_status = 'IN_PROGRESS', a.status_desc = NULL, a.process_time = NULL,
      a.adjustment_code = UPPER (a.adjustment_code)
  WHERE a.request_id     like ('TRKA0776 29.04.2016%')
    AND a.process_status  = 'WAITING';
    
    commit;

-----------------------------------------------------------------    
-- After getting the correct adjustment code, update them back...
-----------------------------------------------------------------

UPDATE ninjadata.batch_adjustment_addition a
  SET a.process_status = 'WAITING', a.status_desc = NULL, a.process_time = NULL,
      a.adjustment_code = UPPER (a.adjustment_code)
  WHERE a.request_id     like ('TRKA0776 29.04.2016%')
    AND /*a.process_status  in ('WAITING','IN_PROGRESS') OR*/
        (a.process_status  = 'PRSD_ERROR' AND 
         STATUS_DESC LIKE '%adjustment code%does not exist%');
         
COMMIT;


SELECT * FROM NINJA_JOBS WHERE EXEC_METHOD = 'batchAdjustmentAddition';