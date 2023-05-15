SELECT a.transaction_number, a.node_ban, a.action_code, a.parent_ban,
       a.tree_root_ban, a.request_id, a.process_status, a.process_time,
       a.status_desc, a.record_creation_date
  FROM batch_tree_activities a
                    
  select process_status, count(*)
  FROM batch_tree_activities
  group by process_status
  
  select * from batch_tree_activities
  where  process_status = 'PRSD_ERROR'
  
  
  update batch_tree_activities 
  set process_status='WAITING'
  where process_status='IN_PROGRESS';
  
--  commit work;
  

         
