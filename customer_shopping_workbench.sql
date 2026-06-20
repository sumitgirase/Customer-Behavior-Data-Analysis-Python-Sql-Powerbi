create database customer_shopping;
use customer_shopping;
# 1)what is the total revenue genereated by male vs female customers?

-- select gender, SUM(purchase_amount) as revenue
-- from customer
-- group by gender

# 2) which customer used a discount but still spent more than average purchase amount?
-- select customer_id ,purchase_amount
-- from customer 
-- where discount_applied = 'Yes' and purchase_amount >= (select AVG(purchase_amount) from customer)

-- Q3. Which are the top 5 products with the highest average review rating?
-- select item_purchased, round( avg(review_rating),2) as "Average Product Rating"
-- from customer
-- group by item_purchased
-- order by avg(review_rating) desc
-- limit 5

#Q4. Compare the average Purchase Amounts between Standard and Express Shipping. 
-- select shipping_type, 
-- ROUND(AVG(purchase_amount),2)
-- from customer
-- where shipping_type in ('Standard','Express')
-- group by shipping_type;

#5) Do subscribed customer spend more ? compare average spend and total revenue
# between subscriber and non subscribers
--  select subscription_status,
--  count(customer_id) as total_customers,
--  round(avg(purchase_amount),2) as avg_spend,
--   round(sum(purchase_amount),2) as total_revenue
--   from customer 
--   group by subscription_status
--   order by total_revenue, avg_spend  desc
  
#6) which 5 products have the highest percentage of purchase with discount applied?
-- select item_purchased,
-- round(100 *sum(case when discount_applied='yes' then 1 else 0 end)/count(*) ,2) as discount_rate
-- from customer 
-- group by item_purchased
-- order by discount_rate desc
-- limit 5;

#Q7. Segment customers into New, Returning, and Loyal based on their total 
#number of previous purchases, and show the count of each segment. 
-- with customer_type as (
-- select customer_id , previous_purchases,
-- case 
--     when previous_purchases =1 then "New"
--     when previous_purchases between 2 and 10 then "Returning"
--     else "Loyal"
--     end as  customer_segment
-- from customer 
-- )
--  select customer_segment , count(*) as "Number of Customers"
--  from customer_type
--  group by customer_segment;


# Q8. What are the top 3 most purchased products within each category? 
-- WITH item_counts AS (
--     SELECT category,
--            item_purchased,
--            COUNT(customer_id) AS total_orders,
--            ROW_NUMBER() OVER (PARTITION BY category ORDER BY COUNT(customer_id) DESC) AS item_rank
--     FROM customer
--     GROUP BY category, item_purchased
-- )
-- SELECT item_rank,category, item_purchased, total_orders
-- FROM item_counts
-- WHERE item_rank <=3;


# Q9. Are customers who are repeat buyers (more than 5 previous purchases) also likely to subscribe?
-- select subscription_status,
-- count(customer_id) as repeat_buyers
-- from customer 
-- where previous_purchases> 5
-- group by subscription_status

#10 what is the revenue contribution of each age group ?
select age_group,
sum(purchase_amount) as total_revenue
from customer 
group by age_group
order by total_revenue desc;
