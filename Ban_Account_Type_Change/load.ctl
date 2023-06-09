Load DATA
INFILE *
BADFILE bad.txt
Append
INTO TABLE ban_acct_type_change
FIELDS TERMINATED BY ";" OPTIONALLY ENCLOSED BY '"'
trailing nullcols
(
TRANS_NUMBER,
 BAN,
 ACCOUNT_TYPE,
 ACCOUNT_SUB_TYPE,
 ENTER_TIME,
 REQUEST_TIME, 
 PROCESS_TIME,
 PROCESS_STATUS,
 STATUS_DESC,
 PRIORITY,
 REQUEST_ID,
 MEMO_TEXT
)