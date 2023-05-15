INSERT INTO subscription_types_socs
SELECT 'NINJAMASTER1',a.soc,NULL,NULL,'Y','O','Y','Y',NULL,NULL,NULL,NULL,NULL,NULL,null from socs a
where not exists (select ' ' 
                  from subscription_types_socs b 
                  where b.subscription_type_id = 'NINJAMASTER1'
                  and a.soc = b.soc);
COMMIT WORK;                  
                   

