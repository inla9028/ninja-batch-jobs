INSERT INTO sub_typ_soc_channel (
subscription_type_id, 
soc, 
channel_code, 
effective_date,
expiration_date, 
channel_mode_at_activation,
channel_mode_for_addition, 
channel_mode_for_modification,
channel_mode_for_deletion, 
channel_mode_display_mode)
SELECT a.subscription_type_id, --*/ 'PVHPREG1',
       a.soc, --*/'MMSPKA', 
       /*a.channel_code, --*/ 'ChessUser',
       a.effective_date,--*/TO_DATE('01052005','DDMMYYYY'),
       a.expiration_date,--*/'' 
       a.channel_mode_at_activation,--*/'N',
       a.channel_mode_for_addition,--*/ 'N', 
       a.channel_mode_for_modification,--*/ 'N', 
       a.channel_mode_for_deletion,--*/ 'N', 
       a.channel_mode_display_mode--*/ 'Y'
  FROM sub_typ_soc_channel a
  WHERE a.subscription_type_id IN ('PVHPREG1')
--  AND a.soc in ('HROFFICE');
  AND a.channel_code = 'NINJAMASTER';
/*  AND NOT EXISTS (SELECT ' ' 
                  FROM sub_typ_soc_channel b
				  WHERE a.subscription_type_id = b.subscription_type_id
				  AND b.soc = 'GAMGSMA' 
				  AND b.channel_code = 'BOL');*/
  COMMIT WORK;
