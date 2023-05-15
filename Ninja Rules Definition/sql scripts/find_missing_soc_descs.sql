select *
from socs a
where not exists (select ' '
                  from  socs_soc_descriptions b
                  where a.soc = b.soc 
                  and language_code = 'NO')
