INSERT INTO ninja_jobs_redesign
SELECT 61, --*/a.job_id, 
       a.job_status, 
       'N', --*/a.was_running, 
       a.sleep_time,
       a.next_exec_time, 
       a.status_time, 
       null, --*/a.status_desc, 
       a.exec_method,
       a.job_desc, 
       a.fixed_start, 
       a.hlr_based
  FROM ninjaconfig.ninja_jobs_redesign@ernst a
  WHERE a.job_id  = 32;
INSERT INTO ninja_jobs_parameters_redesign 
SELECT 61, --*/a.job_id, 
       a.parameter_order, 
       a.parameter_value,
       a.parameter_description
FROM ninjaconfig.ninja_jobs_parameters_redesign@ernst a
WHERE a.job_id  = 32;
COMMIT WORK;       
