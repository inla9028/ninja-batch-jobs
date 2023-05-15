SELECT 'vSubs.add("' || substr(a.subscriber_no, 4) || '");'
  FROM mw_tmp_myhint a
  WHERE exists (SELECT ' ' 
                FROM ntcappo.service_agreement b
                WHERE b.subscriber_no = a.subscriber_no
                AND b.ban = a.customer_id 
                AND rtrim(b.soc) = RTRIM(a.soc)
                AND b.expiration_date > SYSDATE+.5)
  and ROWNUM < 501
  
