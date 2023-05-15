-- All manadatory fields like link_type, city,zip and country must be specified

load data

CHARACTERSET WE8MSWIN1252

into table BATCH_NAME_ADDRESS_UPDATE
append
fields terminated by ";" optionally enclosed by '"'
trailing nullcols
(
link_type,
ban_no,
subscriber_no,
last_business_name,
first_name,
birth_date  DATE "YYYY-MM-DD",
adr_city,
adr_zip,
adr_house_no,
adr_street_name,
adr_pob,
adr_district,
adr_country,
adr_house_letter,
adr_storey,
adr_door_no,
adr_gender,
allow_advertising_ind,
adr_home_phone,
email_addr,
adr_listed_ind,
publish_level,
process_status,
process_time,
status_desc,
record_creation_date,
request_id,
request_user_id,
role_ind,
company_id,
adr_co_name,
additional_title,
person_id
)
