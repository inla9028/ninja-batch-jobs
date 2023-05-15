SELECT a.transaction_number, a.node_ban, a.action_code, a.parent_ban,
       a.tree_root_ban, a.request_id, a.process_status, a.process_time,
       a.status_desc, a.record_creation_date
  FROM batch_tree_activities a
  where a.request_id   = 'TJP190116';
                    
  select process_status, count(*)
  FROM batch_tree_activities
  group by process_status;
  
  
SELECT a.process_status, COUNT(*) AS "COUNT"
FROM ninjadata.batch_tree_activities a
WHERE a.request_id = 'TJP190116'
GROUP BY a.process_status;
  
  select * from batch_tree_activities
  where  process_status = 'PRSD_ERROR' and request_id = 'TJP190116';
  
  
  update batch_tree_activities a
  set a.process_status='WAITING'
  where a.request_id   = 'TJP190116' and a.process_status='IN_PROGRESS';
  
--  commit work;
  

SELECT * FROM NINJA_JOBS WHERE EXEC_METHOD = 'banTreeManipulator';
