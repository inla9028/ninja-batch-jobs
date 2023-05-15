	update  ninjadata.master_transactions  set subscriber_no='GSM04740762585' where trans_number='161001852';
  update  ninjadata.master_transactions  set subscriber_no='GSM04741204826' where trans_number='161001853';
  update  ninjadata.master_transactions  set subscriber_no='GSM04793471975' where trans_number='161001854';
  update  ninjadata.master_transactions  set subscriber_no='GSM04798212659' where trans_number='161001855';
  update  ninjadata.master_transactions  set subscriber_no='GSM04740464936' where trans_number='161001856';
  update  ninjadata.master_transactions  set subscriber_no='GSM04745267483' where trans_number='161001857';
  update  ninjadata.master_transactions  set subscriber_no='GSM04745265113' where trans_number='161001858';
  
  UPDATE ninjadata.master_transactions a
  SET a.process_status = 'WAITING', a.process_time = NULL, a.status_desc = NULL      
  WHERE a.request_id     IN ('2018.05.21.01')
   AND a.enter_time     > TRUNC(SYSDATE)
    AND a.process_status = 'PRSD_ERROR';
  
