load data
into table batch_move_subscribers
append
fields terminated by ";" optionally enclosed by '"'
trailing nullcols
(
  subscriber_no, 
  new_ban,
  new_priceplan, 
  new_campaign_code, 
  handle_commitment, 
  dealer, 
  sales_agent, 
  reason_code, 
  memo_text, 
  keep_user_name,
  waive_fees, 
  is_move_from_sp,
  is_move_to_sp,
  request_id,
  request_user_id,
  skip_ninja_validation
)
