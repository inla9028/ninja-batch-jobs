load data

CHARACTERSET WE8MSWIN1252

into table batch_change_priceplan
append
fields terminated by ";" optionally enclosed by '"'
trailing nullcols
(
  subscriber_no,
  old_priceplan,
  new_priceplan,
  new_campaign_code,
  new_subscription_type,
  handle_commitment,
  SOCS_TO_ADD_FIRST,
  SOCS_TO_DELETE_FIRST,
  socs_to_add,
  SOCS_TO_CLONE,
  socs_to_delete,
  effective_date DATE "YYYY-MM-DD HH24:MI",
  dealer,
  sales_agent,
  reason_code,
  memo_text,
  waive_fees,
  enter_time,
  request_time DATE "YYYY-MM-DD HH24:MI",
  process_time,
  process_status,
  status_desc,
  requestor_id,
  skip_ninja_validation,
  separate_saves
)
