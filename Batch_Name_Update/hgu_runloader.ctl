Load DATA
CHARACTERSET UTF8
INFILE *
Append
INTO TABLE batch_name_update
FIELDS TERMINATED BY ";" OPTIONALLY ENCLOSED BY '"'
trailing nullcols
(
  BAN,
  SUBSCRIBER_NO,
  LINK_TYPE,
  CHG_BIRTH_DATE,
  BIRTH_DATE DATE "YYYY-MM-DD",
  CHG_GENDER,
  GENDER,
  CHG_PID,
  PID,
  NAME_TYPE,
  ROLE_IND,
  ROLE_NAME,
  ADDITIONAL_TITLE,
  FIRST_NAME,
  LAST_NAME,
  COMP_ADDITIONAL_TITLE,
  COMP_NAME,
  CONTACT_NAME,
  ENTER_TIME DATE "YYYY-MM-DD HH24:MI",
  REQUEST_TIME DATE "YYYY-MM-DD HH24:MI",
  REQUESTOR_ID,
  PROCESS_TIME DATE "YYYY-MM-DD HH24:MI",
  PROCESS_STATUS,
  STATUS_DESC
)
