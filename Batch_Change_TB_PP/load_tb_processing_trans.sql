INSERT INTO tb_processing_trans
(subscriber_no,
 sales_agent,
 priceplan,
 campaign,
 handle_commitment,
 reason_code,
 waive_fees,
 sub_tb_soc,
 sub_vpn_code,
 sub_cug_code,
 process_status,
 memo_text,
 requestor_id)
 SELECT subscriber_no,
 null,
 new_priceplan,
 '000000000',
 'K',
 'KON6',
 'Y',
 sub_tb_soc,
 sub_vpn_code,
 sub_cug_code,
 'IN_PROGRESS',
 'Endret til tb. Pga. ny avtale med Veidekke. (REF. ESJ)',
 'RKE 29.10.2004'
 FROM ninjateam.mw_tmp_pptbk_subs;
 COMMIT;

