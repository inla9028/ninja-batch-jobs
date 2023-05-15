load data
into table master_chg_pp_trans
append
fields terminated by ";" optionally enclosed by '"'
trailing nullcols
(
  subscriber_no, 
  new_priceplan, 
  new_campaign_code, 
  new_subscription_type, 
  handle_commitment, 
  effective_date DATE "YYYY-MM-DD HH24:MI",
  dealer, 
  sales_agent, 
  reason_code, 
  memo_text, 
  waive_fees, 
  request_time   DATE "YYYY-MM-DD HH24:MI",
  requestor_id,
  skip_ninja_validation
)
