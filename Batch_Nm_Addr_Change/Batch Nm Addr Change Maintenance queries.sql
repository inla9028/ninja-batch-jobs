
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all records for the specific request.--==--==--==--==--==-=--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.transaction_number, a.link_type, a.ban_no, a.subscriber_no,
       a.last_business_name, a.first_name, a.birth_date, a.adr_city,
       a.adr_zip, a.adr_house_no, a.adr_street_name, a.adr_pob,
       a.adr_district, a.adr_country, a.adr_house_letter, a.adr_storey,
       a.adr_door_no, a.adr_gender, a.allow_advertising_ind,
       a.adr_home_phone, a.email_addr, a.adr_listed_ind,
       a.publish_level, a.process_status, a.process_time, a.status_desc,
       a.record_creation_date, a.request_id, a.request_user_id,
       a.role_ind, a.company_id, a.adr_co_name, a.dsp_ind,
       a.additional_title
  FROM batch_name_address_update  a
  where 'AWG 09.03.2016 03' in (REQUEST_USER_ID , REQUEST_ID)
  and record_creation_date > sysdate -2  
  order by transaction_number
  --and a.process_status='WAITING'
  ;
  
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the status... =--==--==--==--==--==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
  SELECT a.process_status, COUNT(*) AS "Count"
  FROM ninjadata.batch_name_address_update a
  WHERE 'AWG 09.03.2016 03' in (REQUEST_USER_ID , REQUEST_ID)
  and record_creation_date > sysdate -10
  GROUP BY a.process_status 
  ORDER BY a.process_status;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the failed records, with the (trimmed) error description    -==--==
--== This list should be saved in .xls format and sent to the requestor  -==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==

SELECT a.BAN_NO , a.subscriber_no, RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc, ' [ID'))) AS "STATUS_DESC"
FROM batch_name_address_update a
  where 'AWG 09.03.2016 03' in (REQUEST_USER_ID , REQUEST_ID)
  and process_status='PRSD_ERROR'
  and record_creation_date > sysdate -1
  ORDER BY a.status_desc;

/*
Update batch_name_address_update
set publish_level = 'X',
PROCESS_STATUS = 'WAITING'
  where 'AWG 09.03.2016 03' in (REQUEST_USER_ID , REQUEST_ID);
  and record_creation_date > sysdate -1;
  
  commit;
  
Update batch_name_address_update
set LAST_BUSINESS_NAME = '.'  ,
    --FIRST_NAME = 'BOKHARI',
    link_type = 'U',
    STATUS_DESC = '',
    PROCESS_STATUS = 'WAITING'
where 'AWG 09.03.2016 03' in (REQUEST_USER_ID , REQUEST_ID)
and process_status='PRSD_ERROR'
and record_creation_date > sysdate -1;

  Update batch_name_address_update
  set FIRST_NAME = replace (FIRST_NAME, ';',','),
      LAST_BUSINESS_NAME = replace (LAST_BUSINESS_NAME, ';',','),
      STATUS_DESC = '',
      PROCESS_STATUS = 'WAITING'
  where 'AWG 09.03.2016 03' in (REQUEST_USER_ID , REQUEST_ID)
  and record_creation_date > sysdate -2
  and status_desc like '%contains invalid characters%'
  and process_status='PRSD_ERROR'
  ;

commit;

*/

-- UPDATE NINJA_JOBS TO RUN THE requests immediately.
SELECT * FROM NINJA_JOBS WHERE EXEC_METHOD = 'batchNameAddressUpdate';

-- Updating the time to run the job immidiately.....
UPDATE NINJA_JOBS
SET NEXT_EXEC_TIME = SYSDATE
WHERE EXEC_METHOD = 'batchNameAddressUpdate'
AND MACHINE_ID = 'NINJAP1Z_DEMON'
AND job_id = 61; 

COMMIT;