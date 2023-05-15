Load DATA
CHARACTERSET UTF8
INFILE *
Append
INTO TABLE batch_test_subs_creation
FIELDS TERMINATED BY ";" OPTIONALLY ENCLOSED BY '"'
trailing nullcols
(
  BAN,
  CTN, 
  PRICE_PLAN,  
  SOC1,  
  SOC2,  
  SOC3,  
  SOC4,  
  SOC5,  
  SIM_NO,  
  FIRST_NAME,  
  LAST_NAME, 
  POSTAL_ADDRESS,  
  CITY,  
  ZIP_CODE,  
  ACTIVATE,
  REQUEST_TIME,  
  REQUEST_ID
)
