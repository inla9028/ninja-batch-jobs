INSERT INTO subscription_types_socs
SELECT 'PDEFREG1',a.soc,NULL,NULL,'Y','N','N','N',NULL,NULL,NULL,NULL,NULL,NULL,null from socs a
where not exists (select ' ' 
                  from subscription_types_socs b 
                  where b.subscription_type_id = 'PDEFREG1'
                  and a.soc = b.soc);
COMMIT WORK;                  
                   

