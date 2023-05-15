--batch_charge_addition
SELECT a.charge_code, a.request_id, a.request_user_id, a.stream, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR((COUNT(*) * 1.067) / 3600, '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 1.067) / 60, 60),   '9999999'))) || ' min' AS "QUEUE"
  FROM ninjadata.batch_charge_addition a
--  WHERE a.record_creation_date > TRUNC(SYSDATE)
  WHERE a.process_status = 'WAITING'
  GROUP BY a.charge_code, a.request_id, a.request_user_id, a.stream
  ORDER BY a.charge_code, a.request_id, a.request_user_id, TO_NUMBER(a.stream);
  

--batch_adjustment_addition
SELECT a.request_id, a.request_user_id, a.adjustment_code, a.process_status, COUNT(*) as "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR((COUNT(*)     * 1.075) /    3600, '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 1.075) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM ninjadata.batch_adjustment_addition a
 WHERE a.process_status   = 'WAITING'
--    AND */ a.record_creation_date > TRUNC(SYSDATE - 1)
  GROUP BY a.request_id, a.request_user_id, a.adjustment_code, a.process_status
  ORDER BY a.request_id, a.request_user_id, a.adjustment_code, a.process_status;
  
 
--Batch Add_Delete SOC
--Batch_Add_Delete_SOC_No_Features
--Batch Replace SOC 
SELECT TO_NUMBER(a.stream) AS "STREAM", a.process_status, COUNT(*) AS "COUNT"
  FROM ninjadata.master_transactions a
  WHERE a.process_status = 'WAITING'
  GROUP BY a.process_status, TO_NUMBER(a.stream)
  ORDER BY TO_NUMBER(a.stream), a.process_status;

/*
SELECT a.process_status, COUNT(*) AS "COUNT"
  FROM ninjadata.master_transactions a
  WHERE a.process_status = 'WAITING'
  GROUP BY a.process_status
  ORDER BY a.process_status;
*/

--change PP
SELECT a.subscriber_no, a.new_priceplan, a.new_campaign_code,
       a.new_subscription_type, a.handle_commitment, a.effective_date,
       a.dealer, a.sales_agent, a.reason_code, a.memo_text,
       a.waive_fees, a.enter_time, a.request_time, a.process_time,
       a.process_status, a.status_desc, a.priority, trim(a.requestor_id),
       a.skip_ninja_validation, stream, dump(stream)
  FROM master_chg_pp_trans a  
          WHERE  a.enter_time     > TRUNC(SYSDATE) - 1
  AND a.process_status in ('WAITING', 'IN_PROGRESS')
order by process_time;  
 
--publish level
 SELECT a.request_id, a.request_user_id, a.publish_level, a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR((COUNT(*)     * 1.376) / 3600,    '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 1.376) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM ninjadata.batch_publishlevel_update a
  WHERE a.process_status  = 'WAITING'
  GROUP BY a.request_id, a.request_user_id, a.publish_level, a.process_status
  ORDER BY a.request_id, a.request_user_id, a.publish_level, a.process_status;
  
  
--move subscriber
SELECT a.subscriber_no, new_ban, a.new_priceplan, process_time , RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc, ' [ID'))) AS "STATUS_DESC"
  FROM batch_move_subscribers a
          WHERE  a.enter_time     > TRUNC(SYSDATE) - 1
  AND a.process_status in ('WAITING', 'IN_PROGRESS')
order by process_time;  
  
--batch_discount_addition 
SELECT a.subscriber_no, RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc || ' [ID', ' [ID'))) AS "STATUS_DESC"
  FROM ninjadata.batch_discount_addition a
  WHERE a.process_status  = 'WAITING'
--    AND a.status_desc LIKE 'Overlapping Discounts%'
  ORDER BY a.subscriber_no;
  
--status manipulator
SELECT *
  FROM NINJA_SUB_CHANGE_STATUS a
  where process_status  in ('WAITING','IN_PROGRESS')  ;
  
--batchb dsp update  
select * from dsp_response where process_status  in ('WAITING','IN_PROGRESS') ;

select process_status, count(*)
FROM dsp_response a
  where process_status  in ('WAITING','IN_PROGRESS')
  and a.record_creation_date > TRUNC(SYSDATE) -1
  group by process_status;
  
  