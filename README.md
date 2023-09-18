# Analytics engineering with dbt

Template repository for the projects and environment of the course: Analytics engineering with dbt

> Please note that this sets some environment variables so if you create some new terminals please load them again.

## License
GPL-3.0

How many total users?

130

---
SELECT COUNT(*) AS total_users
FROM 
dev_db.dbt_alexazimmermanngmailcom.stg_postgres__users;
---

On average, how many orders do we receive per hour?SELECT AVG(order_count) AS average_orders_per_hour

7.5
--
SELECT AVG(order_count) AS average_orders_per_hour
FROM (
    SELECT COUNT(*) AS order_count
    FROM dev_db.dbt_alexazimmermanngmailcom.stg_postgres__orders
    GROUP BY DATE_TRUNC('hour', created_at)
) subquery;
--

On average, how long does an order take from being placed to being delivered?

5604 minutes ~ 1.5 days

--
SELECT AVG(TIMESTAMPDIFF(MINUTE, created_at, delivered_at)) AS average_delivery_time_minutes
FROM dev_db.dbt_alexazimmermanngmailcom.stg_postgres__orders
WHERE delivered_at IS NOT NULL;
--

How many users have only made one purchase? Two purchases? Three+ purchases?

124 users purchased at least 1 item

--
SELECT COUNT(DISTINCT user_id) AS distinct_user_count
FROM dev_db.dbt_alexazimmermanngmailcom.stg_postgres__orders;
--

25 have ordered 1 item 

-- 
SELECT COUNT(*) AS users_with_one_purchase
FROM (
    SELECT user_id, COUNT(DISTINCT order_id) AS purchase_count
    FROM dev_db.dbt_alexazimmermanngmailcom.stg_postgres__orders
    GROUP BY user_id
    HAVING purchase_count = 1
) AS user_counts;
--

you could do this also with purchase count 2 or 3 

On average, how many unique sessions do we have per hour?

16.33

--
SELECT AVG(unique_sessions) AS average_unique_sessions_per_hour
FROM (
    SELECT DATE_TRUNC('hour', created_at) AS hour,
           COUNT(DISTINCT session_id) AS unique_sessions
    FROM dev_db.dbt_alexazimmermanngmailcom.stg_postgres__events
    GROUP BY hour
) AS session_counts;
--







