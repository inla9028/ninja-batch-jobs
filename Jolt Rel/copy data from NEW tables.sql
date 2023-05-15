truncate table tux_fml_buffers;
ALTER TABLE tux_services
Drop CONSTRAINT tux_services_con100 ;
ALTER TABLE tux_fml_buffers
Drop CONSTRAINT tux_fml_buffers_con100 ;

ALTER TABLE tux_fml_buffers
Drop CONSTRAINT tux_fml_buffers_con101;

ALTER TABLE tux_fml_buffers
Drop CONSTRAINT tux_fml_buffers_con1;

truncate table tux_services;



insert into tux_fml_buffers select * from tux_fml_buffers_new;

insert into tux_services select * from tux_services_new;

-- Constraints for TUX_SERVICES

ALTER TABLE tux_services
ADD PRIMARY KEY (svc_name)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255;

ALTER TABLE tux_services
ADD CONSTRAINT tux_services_con100 CHECK (in_use IN ('Y'));


-- Comments for TUX_SERVICES

COMMENT ON COLUMN tux_services.svc_name IS 'Name of the Tuxedo service.';


-- Constraints for TUX_FML_BUFFERS

ALTER TABLE tux_fml_buffers
ADD PRIMARY KEY (svc_name, buffer_type, field_name)
USING INDEX
  PCTFREE     10
  INITRANS    2
  MAXTRANS    255;

ALTER TABLE tux_fml_buffers
ADD CONSTRAINT tux_fml_buffers_con100 CHECK (buffer_type IN ('IN', 'OUT'));

ALTER TABLE tux_fml_buffers
ADD CONSTRAINT tux_fml_buffers_con101 CHECK (field_type IN ('CARRAY', 'CHAR', 'DOUBLE', 'LONG', 'SHORT', 'STRING'));


-- End of DDL Script for Table NINJADEVCONFIG.TUX_FML_BUFFERS

-- Foreign Key
ALTER TABLE tux_fml_buffers
ADD CONSTRAINT tux_fml_buffers_con1 FOREIGN KEY (svc_name)
REFERENCES tux_services (svc_name);



