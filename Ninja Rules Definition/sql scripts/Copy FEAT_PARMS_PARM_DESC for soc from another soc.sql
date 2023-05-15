-- script to copy existing parameters description for a soc from another soc that has same parameters.
-- if parameter is new it can't be copied and has to be handled manually.

select * from FEAT_PARMS_PARM_DESC
where soc='VMVSVSP'

INSERT INTO FEAT_PARMS_PARM_DESC
   (SOC,
    FEATURE_CODE,
    PARAMETER_CODE,
    PARAMETER_NAME_ID,
    LANGUAGE_CODE)
SELECT  /*SOC, --*/'VMVSVHP',
    FEATURE_CODE,
    PARAMETER_CODE,--*/ 'NUMBER6',
    PARAMETER_NAME_ID,
    LANGUAGE_CODE
FROM FEAT_PARMS_PARM_DESC
WHERE soc = 'VMVSVSP';    --soc t copy from
commit;
