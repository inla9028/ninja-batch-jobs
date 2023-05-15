-- This file Is used To Load the SP Movements from Sense To Chess
-- Edit each Time before a load.
-- The data file must also be edited To Remove the first Line, And To insert 047 prior To each telephone number.

load data
into table sp_subscriber_move
append
fields terminated by "," optionally enclosed by '"'
trailing nullcols
--********************************************************
-- DB TABLE ..
-- SUBSCRIBER_NO, 
-- EXIST_PRICEPLAN, 
-- NEW_SUBSCRIPTION_TYPE, 
-- CHANGE_RATING_REASON_CODE, 
-- ACTIVATION_REASON_CODE, 
-- MEMO_TEXT, 
-- ENTER_TIME, 
-- REQUEST_TIME, 
-- PROCESS_TIME, 
-- PROCESS_STATUS, 
-- STATUS_DESC, 
-- PRIORITY, 
-- REQUESTOR_ID,
-- SKIP_NINJA_VALIDATION
(
SUBSCRIBER_NO, 
EXIST_PRICEPLAN												CONSTANT 'PVSH', 
NEW_SUBSCRIPTION_TYPE 								CONSTANT 'PVHHREG1',
CHANGE_RATING_REASON_CODE							CONSTANT 'VS01', 
ACTIVATION_REASON_CODE								CONSTANT 'PSS', 
MEMO_TEXT															CONSTANT 'Move Sense subscriber to Chess', 
ENTER_TIME														"SYSDATE", 
REQUEST_TIME													"to_date('07092006000100', 'DDMMYYYYHH24MISS')", 
PROCESS_TIME													"NULL", 
PROCESS_STATUS												CONSTANT "ON_HOLD", 
STATUS_DESC														"NULL", 
PRIORITY															CONSTANT '3', 
REQUESTOR_ID													CONSTANT 'LRI CHESS file 4',
SKIP_NINJA_VALIDATION									CONSTANT 'N'
)

