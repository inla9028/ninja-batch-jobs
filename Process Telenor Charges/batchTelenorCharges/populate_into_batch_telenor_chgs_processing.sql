spool populate_batch_telenor_chgs_processing 
set timing on
set serveroutput on size 10000
set pages 40
set lines 200
set echo on
set feedback on

DECLARE
cursor c1 is

select charge_number, charge_date, charge_time, charge_ref,
charge_text, charge_duration, charge_amount,charge_operator
FROM batch_telenor_load_tmp ;

update_row c1%ROWTYPE;

begin

for update_row in c1 loop

insert into BATCH_TELENOR_CHGS_PROCESSING values(
null,
update_row.charge_number,
to_date(update_row.charge_date||update_row.charge_time,'YYYYMMDDHH24MISS'), 
update_row.charge_ref,
update_row.charge_duration,
update_row.charge_amount,
update_row.charge_operator,
NULL,
NULL,
NULL,
NULL,
update_row.charge_text);

commit;

end loop;
end;
/

spool off
exit;
