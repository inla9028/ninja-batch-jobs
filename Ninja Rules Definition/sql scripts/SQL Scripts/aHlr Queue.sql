SELECT phd_id, COUNT(*) AS QUEUED FROM ntcappo.q3
 WHERE phd_id LIKE 'hlr%' AND dvc_trx_sts_cd = 'PE'
 GROUP BY phd_id
