

-- Copy Name Address Records
UPDATE ninjadata.batch_name_address_update@ernst a
SET a.process_status = 'ON_HOLD'
WHERE a.process_status = 'WAITING';
COMMIT;
INSERT INTO batch_name_address_update
SELECT NULL, a.link_type, a.ban_no, a.subscriber_no,
       a.last_business_name, a.first_name, a.birth_date, a.adr_city,
       a.adr_zip, a.adr_house_no, a.adr_street_name, a.adr_pob,
       a.adr_district, a.adr_country, a.adr_house_letter, a.adr_storey,
       a.adr_door_no, a.adr_gender, a.allow_advertising_ind,
       a.adr_home_phone, a.email_addr, a.adr_listed_ind,
       a.publish_level, 'WAITING', a.process_time, a.status_desc,
       a.record_creation_date, a.request_id, a.request_user_id,
       a.role_ind, a.company_id, a.adr_co_name, a.dsp_ind,
       a.additional_title
  FROM ninjadata.batch_name_address_update@ernst a
  WHERE a.process_status = 'ON_HOLD';
UPDATE ninjadata.batch_name_address_update@ernst a
SET a.process_status = 'TRANSFER'
WHERE a.process_status = 'ON_HOLD';
COMMIT;

-- Copy Batch Adjustments
UPDATE ninjadata.batch_adjustment_addition@ernst a
SET a.process_status = 'ON_HOLD'
WHERE a.process_status = 'WAITING';
COMMIT;
INSERT INTO batch_adjustment_addition
SELECT null, a.ban_no, a.subscriber_no,
       a.adjustment_code, a.memo_text, a.user_bill_text, a.amount,
       'WAITING', a.process_time, a.status_desc,
       a.record_creation_date, a.request_id, a.stream,
       a.request_user_id, a.effective_date
  FROM ninjadata.batch_adjustment_addition@ernst a
  WHERE a.process_status = 'ON_HOLD';
UPDATE ninjadata.batch_adjustment_addition@ernst a
SET a.process_status = 'TRANSFER'
WHERE a.process_status = 'ON_HOLD';
COMMIT; 

-- Copy Batch Charge Additions
UPDATE ninjadata.batch_charge_addition@ernst a
SET a.process_status = 'ON_HOLD'
WHERE a.process_status = 'WAITING';
COMMIT;
INSERT INTO batch_charge_addition
SELECT null, a.ban_no, a.subscriber_no, a.charge_code,
       a.actv_reason_code, a.amount, a.user_bill_text, a.memo_text,
       a.effective_date, 'WAITING', a.process_time,
       a.status_desc, a.record_creation_date, a.request_id, a.stream,
       a.request_user_id
  FROM ninjadata.batch_charge_addition@ernst a
  WHERE a.process_status = 'ON_HOLD';
UPDATE ninjadata.batch_charge_addition@ernst a
SET a.process_status = 'TRANSFER'
WHERE a.process_status = 'ON_HOLD';

COMMIT; 



-- Copy COOP Maintenace Batch
  
