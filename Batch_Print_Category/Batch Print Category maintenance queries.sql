SELECT *
  FROM batch_print_category a
  where 'MDL 08.03.2016 02' in ( REQUEST_ID)
  
  
  
  
  select process_status, count(*)
  FROM batch_print_category a
  where a.REQUEST_ID='MDL 08.03.2016 02' 
  group by process_status;



SELECT *
  FROM batch_print_category a
  where a.REQUEST_ID='MDL 08.03.2016 02' 
  and a.process_status='PRSD_ERROR'
  ;

  
  
  