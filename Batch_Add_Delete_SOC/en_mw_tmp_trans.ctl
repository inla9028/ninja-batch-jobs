load data
into table mw_tmp_trans
append
fields terminated by ";" optionally enclosed by '"'
trailing nullcols
(
 subscriber_no, 
 soc, 
 action, 
 dealer_code,
 sales_agent,
 request_id,
 memo_text,
 LOAN_AMOUNT,
 LOAN_INSTALLMENTS, 
 feature, 
 parameter, 
 parm_value,
 feature2,
 parameter2,
 parm_value2,
 feature3,
 parameter3,
 parm_value3,
 feature4,
 parameter4,
 parm_value4,
 feature5,
 parameter5,
 parm_value5
)
