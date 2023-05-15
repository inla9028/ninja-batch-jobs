update tux_fml_buffers
set field_def_value = 'Ninja'
where field_name = 'APPLICATION_ID'
and buffer_type = 'IN';
update tux_fml_buffers
set field_def_value = 'PRDENV' -- 'APPCLNG5'
where field_name = 'ENV_CODE'
and buffer_type = 'IN';
update tux_fml_buffers
set field_def_value = 'NTC'
where field_name = 'MARKET_CODE'
and buffer_type = 'IN';
update tux_fml_buffers
set field_def_value = '0'
where field_name = 'ONLINE_TRX_NO'
and buffer_type = 'IN';
update tux_fml_buffers
set field_def_value = '0'
where field_name = 'SESSION_ID'
and buffer_type = 'IN';
update tux_fml_buffers
set field_def_value = 'O'
where field_name = 'TRANSACTION_MODE'
and buffer_type = 'IN';
update tux_fml_buffers
set field_def_value = '200900'
where field_name = 'OPERATOR_ID'
and buffer_type = 'IN';
commit work;

