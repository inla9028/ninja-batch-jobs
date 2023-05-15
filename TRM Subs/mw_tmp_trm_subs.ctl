load data
into table mw_tmp_trm_subs
append
fields terminated by ";" optionally enclosed by '"'
trailing nullcols
(sub_main_tn, 
 sub_fax_tn, 
 sub_vm_tn, 
 sub_vm_email,
 sub_msg_type, 
 sub_msg_data_type, 
 sub_msg_keep_delete)
