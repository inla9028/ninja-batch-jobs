load data
into table brawe_ban_trees
append
fields terminated by ";" optionally enclosed by '"'
trailing nullcols
(
    tree_root_ban,
    parent_ban,
    ban,
    tree_level,
    account_type,
    account_sub_type,
    ban_status,
    compname1,
    compname2,
    adr_pob,
    adr_street_name,
    adr_zip,
    adr_city,
    effective_date,
    expiration_date
)
