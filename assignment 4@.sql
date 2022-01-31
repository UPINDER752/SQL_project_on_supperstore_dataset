## 1) TASK 1
# This database contains Sales details of transaction of a superstore. 
# The structure has 5 tables
# 1) cust_dimen (containing details about customer and their respective locations)
# 2) prod_dimen (containing product category and their subcategories)
# 3) orders_dimen (with order no, date, and priority)
# 4) shipping_dimen (with ship date, order id and shipping_mode also ship_id) 
# 5)market_fact (containing total sales,discount,shipping cost,profits).
#  = with the data base we easly find the useful data which we require to analyze the data like 
# we find out some data with the help of the the tables.

# 2) TASK 2 
# 1. cust_dimen - Cust_id as Primary Key, no foreign key
# 2. prod_dimen - Prod_id as Primary Key, no foreign key 
# 3. orders_dimen - Ord_id as Primary Key, order_id as foreign key
# 4. shipping_dimen - Ship id as primary key and Order_ID as foreign key.
# 5. market_fact - Ord_id1, Prod_id, Ship_id and Cust_id as foreign key. No Primary Key
#1
select Customer_Name as "Customer Name" , customer_segment as "Customer Segment" from superstore.cust_dimen;
#2
SELECT * from superstore.cust_dimen order by cust_id desc ;
#3
select order_id ,order_date, Order_Priority from superstore.orders_dimen where Order_Priority = 'High';
#4
select sum(sales) as total_sales ,avg(sales) as avg_sales from superstore.market_fact ; 
#5
select max(sales),min(sales) from superstore.market_fact;
#6
select region, count(*) as no_of_customer from superstore.cust_dimen group by region order by no_of_customer desc ; 
#7
select region , count(*) as max_no_of_coustomers from  superstore.cust_dimen group by region order by max_no_of_coustomers desc limit 1 ;
#8
select Customer_name,dense_rank() over ( order by customer_name) from  superstore.cust_dimen inner join superstore.market_fact on cust_id1=cust_id inner join superstore.prod_dimen on Prod_id = prod_id1 where region ='atlantic' and product_sub_category ='tables' group by customer_name;
#9
select customer_name ,dense_rank() over ( order by customer_name) as no_of_small_business_owners from superstore.cust_dimen where province ='ontario' and customer_segment ='small business'group by customer_name;
#10
select prod_id ,count(*) as no_of_product_sold from superstore.market_fact group by prod_id order by no_of_product_sold desc ;
#11
select prod_id as Product_id ,product_sub_category , product_category from superstore.prod_dimen where product_category in ('furniture', 'technology');
#12
select product_category ,profit  from superstore.prod_dimen inner join superstore.market_fact on Prod_id1 = Prod_id  order by product_category desc;  
#13
select product_category ,product_sub_category , profit  from superstore.prod_dimen inner join superstore.market_fact on Prod_id1 = Prod_id order by product_category desc;  
#14
select order_date ,order_quantity , sales  from superstore.orders_dimen inner join superstore.market_fact on ord_id = ord_id1 order by sales desc ; 
#15
select customer_name from superstore.cust_dimen where customer_name  like '_r_d%';
#16
select cust_id ,customer_name,region, sales from superstore.cust_dimen inner join superstore.market_fact on cust_id1 = Cust_id where sales between 1000 and 5000 order by sales desc ;
#17
select  cust_id,sales, dense_rank() over (  order by sales desc) as 3rd_highest from superstore.market_fact where cust_id = 'cust_1351'; 
#18
select region as 'Region' , round(sum(profit),2)"profit in each Region" , count(ship_id) "no of shipment" from superstore.market_fact inner join 
superstore.cust_dimen on Cust_id = cust_id1 inner join superstore.prod_dimen on Prod_id = prod_id1   where product_sub_category =
(select Product_Sub_Category from superstore.market_fact join superstore.prod_dimen on Prod_id = Prod_id1 group by Product_Sub_Category
order by sum(Profit) limit 1)  group by Region order by sum(Profit);



