/*добавить 3 поля*/
alter table users
    ADD column_name_one integer null,
    ADD column_name_two integer null,
    ADD column_name_three integer null,
    ALGORITHM = INSTANT;

/*изменить поле*/
ALTER TABLE users
    RENAME COLUMN column_name_one TO column_name_one_test,
    ALGORITHM = INSTANT;


/**------------**/

CREATE TABLE new_users LIKE Users;

/*добавить 3 поля*/
alter table new_users
    ADD column_name_one integer null,
    ADD column_name_two integer null,
    ADD column_name_three integer null;

/*изменить поле*/
ALTER TABLE new_users
    RENAME COLUMN column_name_one TO column_name_one_test,
    ALGORITHM = INSTANT;

/*добавление ключей*/
ALTER TABLE new_users
    ADD INDEX column_name_one_key (column_name_one),
    ADD INDEX column_name_two (column_name_two);

START TRANSACTION;
    insert into new_users (id, group_id, invited_by_user_id, name, posts_qty) (select * from users);
    RENAME TABLE users TO old_users;
    RENAME TABLE new_users TO users;
COMMIT;




