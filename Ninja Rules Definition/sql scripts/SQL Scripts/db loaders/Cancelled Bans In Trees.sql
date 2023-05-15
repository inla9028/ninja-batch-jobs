CREATE TABLE mw_tmp_can_bans AS
SELECT a.*, b.ban_status
FROM ntcappo.ban_hierarchy_tree a, ntcappo.billing_account b
WHERE a.expiration_date IS NULL
AND a.ban = b.customer_id
AND b.ban_status IN ('C','N');
COMMIT;
