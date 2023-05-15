
Select * From master_chg_pp_trans a
WHERE a.requestor_id     IN ('AFD 05.03.2014')
and PROCESS_STATUS IN ('WAITING', 'IN_PROGRESS')
and  request_time > sysdate -1;

SELECT * FROM NINJA_JOBS WHERE EXEC_METHOD = 'masterPPChanger';

-- Delay the next exec time , so that dealer code and sales agent code can be updated.
update NINJA_JOBS
set NEXT_EXEC_TIME = SYSDATE + 1
WHERE EXEC_METHOD = 'masterPPChanger'
AND MACHINE_ID = 'NINJAP1Z_DEMON'
AND JOB_STATUS = 'SLEEPING';

commit;

-- Update the Request Time to be at Night
update master_chg_pp_trans a
set REQUEST_TIME = TO_DATE('20140305010000','YYMMDDHH24MISS'),
    SKIP_NINJA_VALIDATION='Y'
WHERE a.requestor_id     IN ('AFD 05.03.2014')
and PROCESS_STATUS IN ('WAITING', 'IN_PROGRESS')
and request_time > sysdate -1;

commit;

-- Reset the next exec time 
update NINJA_JOBS
set NEXT_EXEC_TIME = SYSDATE
WHERE EXEC_METHOD = 'masterPPChanger'
AND MACHINE_ID = 'NINJAP1Z_DEMON'
AND JOB_STATUS = 'SLEEPING';

commit;

--For test
update master_chg_pp_trans a
set request_time = sysdate
where subscriber_no in ('GSM04799674924','GSM04799674925','GSM04799674926','GSM04799674927')
and a.requestor_id     IN ('AFD 05.03.2014')
and PROCESS_STATUS IN ('WAITING', 'IN_PROGRESS')
and request_time > sysdate -1;

commit;