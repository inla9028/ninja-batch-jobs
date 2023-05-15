select *
from feature_parameters a
where not exists (select ' ' 
                  from feat_parms_parm_desc b
                  where a.soc = b.soc
                  and   a.feature_code = b.feature_code
                  and   a.parameter_code = b.parameter_code
                  and b.language_code = 'EN')
