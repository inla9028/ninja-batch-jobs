
  delete performance_test where thread_no is not null;
  
  update performance_test
  set thread_no=DECODE(mod(subscriber_no,10),null,1,mod(subscriber_no,10)); 
  commit;
  
  select * from performance_test
  where subscriber_no='04723002104';
  
  select thread_no, machine_id,count(*) 
  from performance_test
  group by thread_no, machine_id;
  
  update performance_test set bean_start = null, bean_end=null, method_start = null, method_end = null, bean_time = null, method_time = null
  where machine_id='WTC';
  commit work;
  
  select a.subscriber_no, a.thread_no, a.bean_time jolt_bean_time, a.method_time jolt_method_time, b.bean_time wtc_bean_time, b.method_time wtc_method_time
  from performance_test a, performance_test b
  where b.thread_no = a.thread_no
  and b.subscriber_no=a.subscriber_no
  and a.machine_id='JOLT'
  and b.machine_id = 'WTC'
  order by a.thread_no
