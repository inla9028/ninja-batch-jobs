CREATE TABLE mw_tmp_replaceable_socs AS 
SELECT a.soc AS new_soc, b.soc AS org_soc, a.soc_type AS new_type, b.soc_type AS org_type, a.soc_group AS new_group, b.soc_group AS org_group
  FROM socs a, socs b
  WHERE a.soc <> b.soc
  AND a.soc_type = b.soc_type
  AND a.soc_type <> 'PRICEPLAN'
  AND b.soc_type <> 'PRICEPLAN'
  AND a.soc <> '*'
  AND b.soc <> '*'
  AND a.soc_type <> 'OTHER'
  AND a.soc_type <> 'ODB' 
  AND b.soc_type <> 'ODB'
  AND a.soc NOT IN ('VMPOST01','VMPOSTF01')
  AND EXISTS (SELECT ' ' FROM subscription_types_socs c
              WHERE c.subscription_type_id NOT IN ('PDEFREG1','NINJAMASTER1')              
              AND a.soc = c.soc
              AND c.add_mode <> 'N')              
  ORDER BY a.soc, b.soc
