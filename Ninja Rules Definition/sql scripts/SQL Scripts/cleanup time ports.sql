DELETE FROM ninja_time_port_srv_ftr_prms a
WHERE EXISTS (SELECT ' ' FROM ninja_time_port b
              WHERE b.ninja_ref_id = a.ninja_ref_id
              AND b.date_time_created < TO_DATE('18092005100000','DDMMYYYYHH24MISS'));
DELETE FROM ninja_time_port_services a
WHERE EXISTS (SELECT ' ' FROM ninja_time_port b
              WHERE b.ninja_ref_id = a.ninja_ref_id
              AND b.date_time_created < TO_DATE('18092005100000','DDMMYYYYHH24MISS'));
DELETE FROM ninja_time_port_equipment a
WHERE EXISTS (SELECT ' ' FROM ninja_time_port b
              WHERE b.ninja_ref_id = a.ninja_ref_id
              AND b.date_time_created < TO_DATE('18092005100000','DDMMYYYYHH24MISS'));
DELETE FROM ninja_time_port_adt_nos a
WHERE EXISTS (SELECT ' ' FROM ninja_time_port b
              WHERE b.ninja_ref_id = a.ninja_ref_id
              AND b.date_time_created < TO_DATE('18092005100000','DDMMYYYYHH24MISS'));
DELETE FROM ninja_time_port_adt_info a
WHERE EXISTS (SELECT ' ' FROM ninja_time_port b
              WHERE b.ninja_ref_id = a.ninja_ref_id
              AND b.date_time_created < TO_DATE('18092005100000','DDMMYYYYHH24MISS'));
DELETE FROM ninja_time_port_sub_info a
WHERE EXISTS (SELECT ' ' FROM ninja_time_port b
              WHERE b.ninja_ref_id = a.ninja_ref_id
              AND b.date_time_created < TO_DATE('18092005100000','DDMMYYYYHH24MISS'));
DELETE FROM ninja_time_port a
WHERE EXISTS (SELECT ' ' FROM ninja_time_port b
              WHERE b.ninja_ref_id = a.ninja_ref_id
              AND b.date_time_created < TO_DATE('18092005100000','DDMMYYYYHH24MISS'));
COMMIT WORK;              
              
