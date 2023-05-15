
update tux_services_new 
set in_use = (select in_use from tux_services where tux_services.svc_name=tux_services_new.svc_name);

update tux_fml_buffers_new
set field_def_value = (select field_def_value from tux_fml_buffers
                       where tux_fml_buffers.svc_name=tux_fml_buffers_new.svc_name
					   and tux_fml_buffers.buffer_type = tux_fml_buffers_new.buffer_type
					   and tux_fml_buffers.field_name = tux_fml_buffers_new.field_name);
					   
--select count (*) from tux_fml_buffers where field_def_value is not null;
--select count (*) from tux_fml_buffers_new where field_def_value is not null;
