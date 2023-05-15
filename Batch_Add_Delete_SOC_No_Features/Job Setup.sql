Select * From ninjateam.hgu_tmp_trans;

/*
-- Schedule for nightly processing...
update ninjateam.hgu_tmp_trans
set request_time = to_date('20130516211000','YYMMDDHH24MISS');

commit;
*/

SELECT * FROM NINJA_JOBS WHERE EXEC_METHOD = 'masterManipulator';

-- Delay the next exec time , so that dealer code and sales agent code can be updated.
update NINJA_JOBS
set NEXT_EXEC_TIME = SYSDATE + 1
WHERE EXEC_METHOD = 'masterManipulator'
AND MACHINE_ID in ('NINJAP2Z_DEMON','NINJAP1Z_DEMON')
AND JOB_STATUS = 'SLEEPING'
and JOB_ID between 50 and 59;

commit;

----------------------------------
/* Run the HGU procedure now... */
-----------------------------------
Select * From master_transactions a
WHERE a.request_id     IN ('AFL 16.05.2014')
and PROCESS_STATUS = 'WAITING'
and enter_time > sysdate -6;

-- Update the codes
/*

update master_transactions a
set DEALER_CODE = 'KSSK',
    SALES_AGENT = 'LCE'
WHERE a.request_id     IN ('AFL 16.05.2014')
and trim(dealer_code) is null AND trim(sales_agent) is null
and PROCESS_STATUS = 'WAITING'
and request_time > sysdate -1;

commit;
*/


-------------------------------------------------------------
-- Set up the job with 5 streams.
--------------------------------------------------------------

select stream , count(*)
FROM ninjadata.master_transactions a
      WHERE a.request_id     IN ('AFL 16.05.2014')
and request_time > sysdate -1
and process_status = 'WAITING'
group by stream
--having stream > 5
;

update ninjadata.master_transactions a
set stream = mod(stream,5) + 1 -- Update all the records to run with max 5 streams.
WHERE a.request_id     IN ('AFL 16.05.2014')
and request_time > sysdate -1
and process_status = 'WAITING'
--and stream > 3
;

commit;

-----------------------------------------------------------------
-- Reset the next exec time 
-----------------------------------------------------------------
update NINJA_JOBS
set NEXT_EXEC_TIME = SYSDATE
WHERE EXEC_METHOD = 'masterManipulator'
AND MACHINE_ID in ('NINJAP2Z_DEMON','NINJAP1Z_DEMON')
AND JOB_STATUS = 'SLEEPING'
and JOB_ID between 50 and 59;

commit;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Set up the streams based on last digit of the Ban where the subscriber resides. This will prevent the locks where 2 streams are processing the subscriber under the same ban
------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Update ninjadata.master_transactions a
set a.stream = (Select MOD(SUBSTR(max(customer_id),9),10) + 1
                from Subscriber@fokus S1
                where Subscriber_No = a.Subscriber_No)
WHERE a.request_id     IN ('AFL 16.05.2014')
and request_time > sysdate -1
AND a.process_status = 'WAITING';    

commit;