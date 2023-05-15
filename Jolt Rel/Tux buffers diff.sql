truncate table TUX_FML_BUFFERS_OLD;

insert into TUX_FML_BUFFERS_OLD select * from TUX_FML_BUFFERS;

select tfb.* from tux_fml_buffers_new tfb, tux_services_new ts
where 
ts.svc_name=tfb.svc_name
--and in_use='Y'
and not exists(
select 1 from tux_fml_buffers_old tfbo
where tfbo.field_name = tfb.field_name
and tfbo.svc_name = tfb.svc_name
and tfbo.buffer_type = tfb.buffer_type 
and tfbo.field_max_occurence = tfb.field_max_occurence);

select * from tux_fml_buffers_old tfb, tux_services ts
where 
ts.svc_name=tfb.svc_name
--and in_use='Y'
and not exists(
select 1 from tux_fml_buffers_new tfbo
where tfbo.field_name = tfb.field_name
and tfbo.svc_name = tfb.svc_name
and tfbo.buffer_type = tfb.buffer_type );

