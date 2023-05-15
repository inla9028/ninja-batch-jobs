DELETE FROM mw_tmp_myhint a
WHERE NOT EXISTS (SELECT ' ' 
                  FROM ntcappo.service_agreement b
                  WHERE b.subscriber_no = a.subscriber_no
                  AND b.ban = a.customer_id
                  AND b.soc = a.soc
                  AND b.expiration_date > SYSDATE);
                  COMMIT;
