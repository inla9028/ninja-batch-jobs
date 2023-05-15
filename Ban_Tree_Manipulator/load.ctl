-- All mandatory fields should be specified
-- Data file should be *.csv 

Load DATA
BADFILE bad.txt
Append
INTO TABLE batch_tree_activities
FIELDS TERMINATED BY ";" OPTIONALLY ENCLOSED BY '"' 
trailing nullcols
(
	NODE_BAN,
	ACTION_CODE,
	PARENT_BAN,
	REQUEST_ID,
	PROCESS_STATUS CONSTANT 'IN_PROGRESS',
	RECORD_CREATION_DATE SYSDATE
	
)

