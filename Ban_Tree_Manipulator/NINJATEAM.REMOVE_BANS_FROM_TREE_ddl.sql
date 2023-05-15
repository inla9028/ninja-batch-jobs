-- Start of DDL Script for Package Body NINJATEAM.REMOVE_BANS_FROM_TREE
-- Generated 25.11.2004 16:26:59 from NINJATEAM@ERNST.WSRV1.NETCOM-GSM.NO

CREATE OR REPLACE 
PACKAGE BODY remove_bans_from_tree
IS
--  Populate ban_tree_member_removal table for removing cancelled and closed bans from trees.
-- 
--
-- MODIFICATION HISTORY
-- Person      Date    Comments
-- ---------   ------  ------------------------------------------      

   PROCEDURE load_tmp_tree_can_bans IS

        cursor1 integer ;
    begin
      -- Truncate table before loading...
      cursor1:= dbms_sql.open_cursor;
      dbms_sql.parse(cursor1, 'TRUNCATE TABLE TMP_TREE_CAN_BANS', dbms_sql.native);
      dbms_sql.close_cursor(cursor1);
      commit;

       insert into tmp_tree_can_bans 
        SELECT a.*, b.ban_status
        FROM ban_hierarchy_tree@PROD.WORLD a, billing_account@PROD.WORLD b
        WHERE a.expiration_date IS NULL
        AND a.ban = b.customer_id
        AND b.ban_status IN ('C','N');
       COMMIT;
       
       --This then makes sure that parent bans are remopved before child bans..
        UPDATE tmp_tree_can_bans SET tree_level = 10 - tree_level;
        commit work;
    END load_tmp_tree_can_bans;
    
    PROCEDURE load_ban_tree_member_removal IS
        BEGIN
            insert into ninjadata.ban_tree_member_removal
            select null,
                   ban,
                   null,
                   null,
                   null,
                   null,
                   null,
                   tree_level,
                   'FEB RUN'
            from tmp_tree_can_bans;
            commit;
    
    END load_ban_tree_member_removal;
END;
/


-- End of DDL Script for Package Body NINJATEAM.REMOVE_BANS_FROM_TREE

