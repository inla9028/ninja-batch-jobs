load data
into table hgu_responsetime_logs
append
fields terminated by ";" optionally enclosed by '"'
trailing nullcols
(
 server_name,
 instance_name,
 process_time TIMESTAMP "YYYY-MM-DD HH24:MI:SS,FF3",
 process_name,
 duration
)
