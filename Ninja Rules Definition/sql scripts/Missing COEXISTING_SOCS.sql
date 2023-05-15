
SELECT 'insert INTO coexisting_socs values(''' || rtrim(a.soc_first) || ''',''' || rtrim(a.soc_second) || ''',''I'');' 
  FROM ntcrefwork.soc_illegal_comb@prod.world a
  WHERE a.illegal_ind = 'Y'
  AND NVL(a.expiration_date, SYSDATE +1) > sysdate
AND NOT EXISTS (SELECT ' ' 
                FROM coexisting_socs b
                WHERE (b.soc = rtrim(a.soc_first) AND b.coexisting_soc = RTRIM(a.soc_second))
                OR (b.coexisting_soc = rtrim(a.soc_first) AND b.soc = RTRIM(a.soc_second)))
                
AND EXISTS (SELECT ' ' FROM socs c WHERE c.soc = RTRIM(a.soc_first))
AND EXISTS(SELECT ' ' FROM socs d WHERE d.soc = RTRIM(a.soc_second))
                
