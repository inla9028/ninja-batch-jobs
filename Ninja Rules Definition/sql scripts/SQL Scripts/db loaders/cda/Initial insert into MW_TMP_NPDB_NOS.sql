INSERT INTO mw_tmp_npdb_nos (fixed_line_no, date_imported) 
SELECT '0' || a.fixed_line_no,a.date_imported
FROM mw_tmp_nrpd_dump a;
COMMIT;
