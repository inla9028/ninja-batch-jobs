insert into subscription_types_socs a
      (a.subscription_type_id, a.soc, a.effective_date,
       a.expiration_date, a.displayable, a.add_mode, a.modify_mode,
       a.delete_mode, a.ninja_mode_activate, a.ninja_mode_change,
       a.ninja_mode_delete, a.ninja_replacement_soc, a.overidden_by_soc,
       a.additionally_adds_soc, a.ninja_default_soc)
  select 
       /*a.subscription_type_id, --*/ 'PTTBREG1',
       /*a.soc, --*/ 'TBSTAT5',
       a.effective_date,
       a.expiration_date, 
       a.displayable, 
       a.add_mode, 
       a.modify_mode,
       a.delete_mode, 
       a.ninja_mode_activate, 
       a.ninja_mode_change,
       a.ninja_mode_delete, 
       a.ninja_replacement_soc, 
       a.overidden_by_soc,
       a.additionally_adds_soc, 
       a.ninja_default_soc
  FROM subscription_types_socs a
  where subscription_type_id in ('PSUBREG1')
  --and channel_code='NINJAMASTER'
  and soc = 'TBSTAT1';

  commit work;
