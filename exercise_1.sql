/*Выборки пользователей, у которых количество постов больше, чем у пользователя их пригласившего.*/
SELECT U.*
FROM users U
         LEFT JOIN users AS IU ON U.invited_by_user_id = IU.id
WHERE U.posts_qty > IU.posts_qty

/*Выборки пользователей, имеющих максимальное количество постов в своей группе.*/
SELECT U.id,
       U.group_id,
       U.invited_by_user_id,
       U.name,
       U.posts_qty
FROM (SELECT *,
             RANK() OVER(partition by group_id ORDER BY posts_qty DESC) AS Top
      FROM users) AS U
WHERE U.Top = 1

/*Выборки групп, количество пользователей в которых превышает 10000.*/
SELECT G.*, COUNT(U.id) AS qty_users
FROM service.groups AS G
         LEFT JOIN users U on G.id = U.group_id
GROUP BY G.id
having qty_users > 10000
/*OR*/
SELECT *
FROM (SELECT G.*, COUNT(U.id) AS qty_users
      FROM service.groups G
               LEFT JOIN users U on G.id = U.group_id
      group by G.id) AS E
WHERE E.qty_users > 10000

/*Выборки пользователей, у которых пригласивший их пользователь из другой группы.*/
SELECT U.*
FROM users U
         LEFT JOIN users IU ON U.invited_by_user_id = IU.id
WHERE U.group_id != IU.group_id

/*Выборки групп с максимальным количеством постов у пользователей.*/
SELECT G.*, SUM(U.posts_qty) AS sum_posts
FROM service.groups G
         LEFT JOIN users U on G.id = U.group_id
group by G.id
ORDER BY sum_posts DESC