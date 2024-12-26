-- Problem 1 : Game Play Analysis II(https://leetcode.com/problems/game-play-analysis-ii/)
with cte as (
select player_id,device_id, row_number() over(partition by player_Id order by event_date)as rnk from activity
)
select player_id,device_id from cte where rnk =1

--Problem 2 : Game Play Analysis III(https://leetcode.com/problems/game-play-analysis-iii/)

select distinct(player_id), event_date, sum(games_played) over (partition by player_id order by event_date) as games_played_so_far 
from activity order by event_date

--Problem 3 : Shortest Distance in a Plane(https://leetcode.com/problems/shortest-distance-in-a-plane/)
WITH Distance AS (
    SELECT 
        ROUND(SQRT(POW(p1.x - p2.x, 2) + POW(p1.y - p2.y, 2)), 2) AS dist
    FROM 
        Point2D p1
    JOIN 
        Point2D p2
    ON 
        p1.x != p2.x OR p1.y != p2.y
)
SELECT 
    MIN(dist) AS shortest
FROM 
    Distance;
--4 Problem 4 : Combine Two Tables(https://leetcode.com/problems/combine-two-tables/)
select p.firstName,p.lastName,a.city,a.state from Person p
left join Address a on p.personId = a.personId


--Problem 5 : Customers with Strictly Increasing Purchases(https://leetcode.com/problems/customers-with-strictly-increasing-purchases/)
with cte as(
select customer_id, year(order_date) as 'Year', sum(price)as total_price
from orders o
group by customer_id,year
order by customer_id,year
)
select c.customer_id from cte c left join cte c1 on c.customer_id = c1.customer_id and c.year +1 = c1.year and c.total_price < c1.total_price 
group by c.customer_id
having count(*)- count(c1.customer_id) = 1