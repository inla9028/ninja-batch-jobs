insert into sub_typ_soc_channel
SELECT /*'PKOPREG1', --*/subscription_type_id, 
       soc, 
       'MINSIDE',--*/channel_code, 
       effective_date,
       expiration_date, 
       /*'N', --*/channel_mode_at_activation,
       /*'N', --*/channel_mode_for_addition, 
       /*'N', --*/channel_mode_for_modification,
       /*'N', --*/channel_mode_for_deletion, 
       /*'Y' --*/channel_mode_display_mode
  FROM sub_typ_soc_channel
WHERE channel_code = 'NINJAMASTER'
AND subscription_type_id IN ('PPOGREG1','PPCAREG1');
  commit;
