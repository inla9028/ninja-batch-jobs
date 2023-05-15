set echo on
spool delete_existing

delete batch_telenor_load_tmp 
where exists 
(select 1 from BATCH_TELENOR_CHGS_PROCESSING
where 
BATCH_TELENOR_CHGS_PROCESSING.charge_ref = batch_telenor_load_tmp.charge_ref
);

commit;
exit;
