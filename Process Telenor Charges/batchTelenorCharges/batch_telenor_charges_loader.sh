sqlplus ninjadata/ninjadata@ni01p @delete_batch_telenor_load_temp.sql
sqlldr userid=ninjadata/ninjadata@ni01p control=tnor_charges.ctl data=tnor_charges.txt errors=0
sqlplus ninjadata/ninjadata@ni01p @delete_existing.sql
sqlplus ninjadata/ninjadata@ni01p @populate_into_batch_telenor_chgs_processing.sql

