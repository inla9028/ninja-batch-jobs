load data
into table batch_tree_cug_addition
append
fields terminated by ";" optionally enclosed by '"'
trailing nullcols
(
 root_ban,
 parent_ban,
 soc,
 pni,
 memo_text,
 request_id, 
 action_code,
 soc_effective_date "TO_DATE(:SOC_EFFECTIVE_DATE,'YYYYMMDD')"
)
