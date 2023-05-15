load data
into table batch_sim_release
append
fields terminated by ";" optionally enclosed by '"'
trailing nullcols
(
	sim_no,
	update_db,
	dealer,
	sales_agent,
	request_id,
	request_time         DATE "YYYY-MM-DD HH24:MI",
	record_creation_date DATE "YYYY-MM-DD HH24:MI",
	process_status,
	process_time,
	status_desc
)
