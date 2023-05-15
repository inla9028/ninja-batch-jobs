insert into sub_typ_soc_channel
select a.subscription_type_id,a.soc,'NINJAMASTER',a.effective_date,a.expiration_date, null,null,null,null,null
from subscription_types_socs a
WHERE NOT EXISTS (SELECT ' '
                FROM sub_typ_soc_channel b
                WHERE b.subscription_type_id = a.subscription_type_id
                AND b.soc = a.soc
                AND b.channel_code = 'NINJAMASTER');
commit work;
