load data
CHARACTERSET UTF8
into table batch_add_soc_w_exp_date
append
fields terminated by ";" optionally enclosed by '"'
trailing nullcols
(
 SUBSCRIBER_NO,
 SOC,
 EXPIRATION_DATE DATE "YYYY-MM-DD HH24:MI",
 PARAMETERS,
 DEALER,
 MEMO,
 REQUEST_ID,
 ENTER_TIME,
 REQUEST_TIME DATE "YYYY-MM-DD HH24:MI",
 process_time,
 process_status,
 status_desc
)
