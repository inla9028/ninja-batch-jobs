select * from ninja_jobs
where EXEC_METHOD = 'statusManipulator';

------------------------------------------
-- Set the status to STOPPING
--------------------------------------------
update ninja_jobs
set job_status = 'STOPPING'
where EXEC_METHOD = 'statusManipulator';

commit;

---------------------------------------------------------------------------------------------------------------------------
-- Load the records using the sqlldr to NINJA_SUB_CHANGE_STATUS
-- update the records in 'NINJA_SUB_CHANGE_STATUS' with desired request time
---------------------------------------------------------------------------------------------------------------------------

update NINJA_SUB_CHANGE_STATUS
set REQUEST_TIME = to_date('20120510000100','YYYYMMDDHH24MISS'),
REQUEST_REFERENCE_ID = 'tobj1039' || '09.May.2012'
where REQUEST_REFERENCE_ID = 'tobj1039';

------------------------------------------
-- Set the status back to WAITING
--------------------------------------------
update ninja_jobs
set job_status = 'STARTING'
where EXEC_METHOD = 'statusManipulator';