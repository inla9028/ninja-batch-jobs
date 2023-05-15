-- script to copy soc descriptin from another existing soc when new soc can have same 
-- description as the existing one.

insert into socs_soc_descriptions (soc,
                                   soc_name_id,
                                   language_code)
select 'MMSVBH',
        soc_name_id,
        language_code
from socs_soc_descriptions
where soc = 'MMSVAH';
commit;          
