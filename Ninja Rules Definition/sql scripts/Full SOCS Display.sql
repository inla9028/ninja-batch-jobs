SELECT a.soc, a.soc_group, a.soc_type, b.language_code, c.description, c.soc_name_id
  FROM socs a, socs_soc_descriptions b, soc_descriptions c
  WHERE a.soc = b.soc
  AND b.soc_name_id = c.soc_name_id
  AND b.language_code = c.language_code
  ORDER BY a.soc, b.language_code
