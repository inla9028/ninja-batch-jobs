load data
CHARACTERSET UTF8
into table master_memo_transactions
append
fields terminated by ";" optionally enclosed by '"'
trailing nullcols
(subscriber_no,
 ban_no,
 memo_text,
 memo_sys_text,
 memo_type,
 sys_mem_append,
 exclude_ind
 )
