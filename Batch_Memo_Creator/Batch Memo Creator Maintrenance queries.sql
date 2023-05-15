--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all records for the specific request.--==--==--==--==--==-=--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.trans_number, a.subscriber_no, a.ban_no, a.memo_text,
       a.memo_sys_text, a.memo_type, a.sys_mem_append, a.enter_time,
       a.request_time, a.process_time, a.process_status, a.status_desc,
       a.priority, a.exclude_ind
  FROM master_memo_transactions a
  where memo_text like 'The sub has got updated OCSI and SMSCSI triggers in HLR%';
  
  
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the status... =--==--==--==--==--==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
  select process_status, count(*)
  FROM master_memo_transactions a
  where memo_text like 'The sub has got updated OCSI and SMSCSI triggers in HLR%'
  group by process_status;
  
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the failed records, with the (trimmed) error description    -==--==
--== This list should be saved in .xls format and sent to the requestor  -==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
  SELECT a.subscriber_no,  a.ban_no, a.memo_text,RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc, ' [ID'))) AS "STATUS_DESC"
  FROM ninjadata.master_memo_transactions a
  where memo_text like 'The sub has got updated OCSI and SMSCSI triggers in HLR%'
    AND a.process_status  = 'PRSD_ERROR'
  ORDER BY a.subscriber_no, a.status_desc;
  
  
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--== Check if all records were loaded successfully and if so then ==-- 
--== run the statement to set process_status to WAITING           ==--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--    
  UPDATE ninjadata.master_memo_transactions a
  SET a.process_status = 'WAITING'
  WHERE a.memo_text like 'The sub has got updated OCSI and SMSCSI triggers in HLR%'
    AND a.process_status = 'IN_PROGRESS';
    
    commit;


SELECT * FROM NINJA_JOBS WHERE EXEC_METHOD = 'masterMemoCreator';


