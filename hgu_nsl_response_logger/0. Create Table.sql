CREATE TABLE hgu_responsetime_logs
    (server_name                    VARCHAR2(32) NOT NULL,
    instance_name                   VARCHAR2(32) NOT NULL,
    process_time                   TIMESTAMP NOT NULL,
    process_name                   VARCHAR2(128) NOT NULL,
    duration                       NUMBER(10,0) NOT NULL)
/

-- Grants for Table

GRANT ALTER ON hgu_responsetime_logs TO ninjamain_st
/
GRANT DELETE ON hgu_responsetime_logs TO ninjamain_st
/
GRANT INDEX ON hgu_responsetime_logs TO ninjamain_st
/
GRANT INSERT ON hgu_responsetime_logs TO ninjamain_st
/
GRANT SELECT ON hgu_responsetime_logs TO ninjamain_st
/
GRANT UPDATE ON hgu_responsetime_logs TO ninjamain_st
/
GRANT REFERENCES ON hgu_responsetime_logs TO ninjamain_st
/


-- Indexes for hgu_responsetime_logs

CREATE INDEX hgu_responsetime_logs_idx1 ON hgu_responsetime_logs
  (
    server_name                  ASC,
    process_name                 ASC
  )
/

CREATE INDEX hgu_responsetime_logs_idx2 ON hgu_responsetime_logs
  (
    process_name                 ASC,
    process_time                 ASC,
    duration                     ASC
  )
/


-- Comments for hgu_responsetime_logs

COMMENT ON TABLE hgu_responsetime_logs IS 'Holds durations, that can easily be displayed / exported'
/
COMMENT ON COLUMN hgu_responsetime_logs.server_name IS 'The server/machine from which the durations were fetched'
/
COMMENT ON COLUMN hgu_responsetime_logs.instance_name IS 'The name of the server-instance from which the durations were fetched'
/
COMMENT ON COLUMN hgu_responsetime_logs.process_time IS 'Time when the processing took place'
/
COMMENT ON COLUMN hgu_responsetime_logs.process_name IS 'The name of the method/process that took place'
/
COMMENT ON COLUMN hgu_responsetime_logs.duration IS 'The duration of the method/process'
/
