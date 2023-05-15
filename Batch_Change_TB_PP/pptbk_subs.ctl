load data
into table mw_tmp_pptbk_subs
append
fields terminated by ";" optionally enclosed by '"'
trailing nullcols
(SUBSCRIBER_NO,NEW_PRICEPLAN,SUB_VPN_CODE,SUB_CUG_CODE,SUB_TB_SOC)
