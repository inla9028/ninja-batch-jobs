UPDATE mw_tmp_pptbk_subs a
SET a.existing = (SELECT rtrim(b.soc) 
                  FROM service_agreement@prod.world b 
				  WHERE a.subscriber_no = b.subscriber_no
				  AND b.expiration_date > SYSDATE 
				  AND b.service_type = 'P');
COMMIT;


UPDATE mw_tmp_pptbk_subs a
SET a.existing_tb_soc = (SELECT rtrim(b.soc) 
                  FROM service_agreement@prod.world b 
				  WHERE a.subscriber_no = b.subscriber_no
				  AND b.soc LIKE 'MCT%'
				  AND b.service_type = 'R'
				  AND b.expiration_date > SYSDATE );
COMMIT;

UPDATE mw_tmp_pptbk_subs a
SET a.existing_cug = (SELECT rtrim(b.ftr_add_sw_prm) 
                  FROM service_feature@prod.world b 
				  WHERE a.subscriber_no = b.subscriber_no
				  AND rtrim(b.soc) = a.existing_tb_soc
				  AND b.feature_code = 'CUG'
				  AND b.ftr_expiration_date > SYSDATE );
COMMIT;

UPDATE mw_tmp_pptbk_subs a
SET a.existing_vpn = (SELECT rtrim(b.ftr_add_sw_prm) 
                  FROM service_feature@prod.world b 
				  WHERE a.subscriber_no = b.subscriber_no
				  AND rtrim(b.soc) = a.existing_tb_soc
				  AND b.feature_code = 'M-VPT2'
				  AND b.ftr_expiration_date > SYSDATE );
COMMIT;

--UPDATE mw_tmp_pptbk_subs
--SET new_priceplan = existing 
--WHERE new_priceplan = 'PSTB' AND existing = 'PSUB';
--COMMIT;

select * from mw_tmp_pptbk_subs;

--truncate table mw_tmp_pptbk_subs; 


						  

