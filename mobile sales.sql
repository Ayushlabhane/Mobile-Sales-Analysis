create table mobile_data(
Transaction_ID int primary key, 
date_of_sale date,
Day_Name Varchar(15),
Brand varchar(15),
Units_Sold int,
Price_Per_Unit decimal(8,2),
City varchar(25),
Payment_Method varchar(20),
Customer_Ratings int,
Mobile_Model  varchar(25)
);

create table customer_data(
Transaction_ID int,
Customer_Name varchar (30),
Customer_Age int,
constraint fk_user foreign key (Transaction_ID) references mobile_data(Transaction_ID) on delete set null
);

select * from mobile_data;
select * from customer_data;

select brand, sum(Units_Sold * Price_Per_Unit) as total_amount from mobile_data
group by brand
order by total_amount desc;

select Mobile_Model , sum(Units_Sold)  as total_unit_sold from mobile_data
group by Mobile_Model
order by total_unit_sold desc;

select Payment_Method, sum(Units_Sold * Price_Per_Unit) as total_amount from mobile_data
group by Payment_Method
order by total_amount desc;

select City, sum(Units_Sold * Price_Per_Unit) as total_amount from mobile_data
group by City
order by total_amount desc;

select Day_Name, sum(Units_Sold) as total_units_sold from mobile_data
group by Day_Name
order by total_units_sold desc;

select date_of_sale, sum(Units_Sold) as total_units_sold from mobile_data
group by date_of_sale
order by total_units_sold desc;

select Mobile_Model, round(avg(Customer_Ratings),1) as avg_rating from mobile_data
group by Mobile_Model 
order by avg_rating desc;

select b.Customer_Name, sum(a.Units_Sold * a.Price_Per_Unit) as total_spent from mobile_data a 
join customer_data b
on a.Transaction_ID=b.Transaction_ID 
group by b.Customer_Name
order by total_spent desc;


select Day_Name, sum(Units_Sold * Price_Per_Unit) as total_amount from mobile_data
group by Day_Name
order by total_amount desc;

select b.Customer_Name, sum(a.Units_Sold * a.Price_Per_Unit) as total_spent,
round(avg(a.Customer_Ratings), 2) as avg_rating
from mobile_data a
join customer_data b
on a.Transaction_ID=b.Transaction_ID
GROUP BY b.Customer_Name
ORDER BY total_spent DESC;

select Mobile_Model, round(avg(Price_Per_Unit),2) as avg_price,
sum(Units_Sold) as total_units from mobile_data
group by Mobile_Model
order by avg_price desc;

select City, Brand, sum(Units_Sold * Price_Per_Unit) as total_amount
from mobile_data
group by City, Brand
order by City, total_amount desc;


select case
when Price_Per_Unit < 10000 then 'Budget'
when Price_Per_Unit between 10000 and 20000 then 'Mid-Range'
else 'Premium'
end as price_category,
SUM(Units_Sold) as total_units_sold
from mobile_data
group by price_category
order by total_units_sold desc;

select 
City,
sum(Units_Sold) as total_units,
sum(Units_Sold * Price_Per_Unit) as total_revenue
from mobile_data
group by City
order by total_revenue desc;

select  Customer_Ratings, count(*) as rating_count
from mobile_data
group by Customer_Ratings
order by Customer_Ratings desc;

select Brand, count(distinct date_of_sale) as active_sales_days,
sum(Units_Sold) as total_units
from mobile_data
group by Brand
order by active_sales_days desc;

select case
when Customer_Age < 25 then 'Under 25'
when Customer_Age between 25 and 40 then '25-40'
else'Above 40'
end as age_group,
sum (m.Units_Sold * m.Price_Per_Unit) as total_spent
from mobile_data m
join customer_data c
on m.Transaction_ID = c.Transaction_ID
group by age_group
order by total_spent desc;




