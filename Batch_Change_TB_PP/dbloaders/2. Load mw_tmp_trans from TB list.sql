-- INSERT Modifications
INSERT INTO mw_tmp_trans
  SELECT subscriber_no, sub_tb_soc, 'MODIFY', 'CUG',' CUG', sub_cug_code, 'TB-TEAM ' || TO_CHAR(SYSDATE, 'DD.MM.YYYY'), NULL, 'M-VPT2', 'VPN', sub_vpn_code, NULL, NULL, NULL, NULL, NULL, NULL
  FROM mw_tmp_pptbk_subs
  WHERE sub_tb_soc = existing_tb_soc
    AND new_priceplan = existing;
DELETE FROM mw_tmp_pptbk_subs
  WHERE sub_tb_soc = existing_tb_soc;
COMMIT;


-- Insert any that don't require a VPN Code Change
INSERT INTO mw_tmp_trans
SELECT subscriber_no, sub_tb_soc, 'ADD', 'CUG',' CUG', sub_cug_code, 'TB-TEAM ' || TO_CHAR(SYSDATE, 'DD.MM.YYYY'), NULL, 'M-VPT2', 'VPN', sub_vpn_code, NULL, NULL, NULL, NULL, NULL, NULL
FROM mw_tmp_pptbk_subs 
WHERE new_priceplan = existing ;
DELETE FROM mw_tmp_pptbk_subs 
WHERE new_priceplan = existing;
COMMIT;
 
-- Add any that don't have a TB Soc but don't need a priceplan Change
INSERT INTO mw_tmp_trans
SELECT subscriber_no, sub_tb_soc, 'ADD', 'CUG',' CUG', sub_cug_code,  'TB-TEAM ' || TO_CHAR(SYSDATE, 'DD.MM.YYYY'), NULL, 'M-VPT2', 'VPN', sub_vpn_code, NULL, NULL, NULL, NULL, NULL, NULL
FROM mw_tmp_pptbk_subs 
WHERE new_priceplan = existing 
AND existing_tb_soc IS NULL;
DELETE FROM mw_tmp_pptbk_subs 
WHERE new_priceplan = existing 
AND existing_tb_soc IS NULL;
COMMIT;
 
-- The Remaining records in mw_tmp_pptbk_subs require a Priceplan Change.

select * from mw_tmp_pptbk_subs
