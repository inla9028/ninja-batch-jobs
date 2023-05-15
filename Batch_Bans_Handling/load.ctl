-- All mandatory fields should be specified
-- Data file should be *.csv 
Load DATA

CHARACTERSET WE8MSWIN1252

BADFILE bad.txt
Append
INTO TABLE batch_bans_activity
FIELDS TERMINATED BY ";" OPTIONALLY ENCLOSED BY '"' 
trailing nullcols
(
	BAN_NO,
	ACTION,
	REASON_CODE,
	ACTIVITY_DATE "DECODE(:ACTIVITY_DATE,null,null,TO_DATE(:ACTIVITY_DATE,'YYYY-MM-DD'))",	
	MEMO_TEXT,
	REQUEST_ID
)

