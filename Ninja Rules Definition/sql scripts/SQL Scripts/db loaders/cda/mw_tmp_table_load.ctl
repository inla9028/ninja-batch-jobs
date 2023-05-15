load data
into table mw_tmp_nrpd_dump
append
fields terminated by "," optionally enclosed by '"'
trailing nullcols
(
fixed_line_no,
date_imported
)
