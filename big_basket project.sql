-- 1] total no of brands available in big basket
SELECT count(distinct(brand)) AS TOTALL_BRANDS  FROM big_basket

-- 2] total categories of product available
select count(distinct(category)) as totall_category from big_basket

-- 3] total sub categories of product availabe
select count(distinct(sub_category)) as totall_sub_category from big_basket

-- 4] top 5 categories
select category,count(category) as category  from big_basket
group by category
order by category desc
limit 5

-- 5] top 10 sub categories
select sub_category,count(sub_category) as sub_category from big_basket
group by sub_category
order by sub_category desc
limit 10

-- 6] top 3 costly product name
select product,max(market_price) as costly_product from big_basket
group by product
order by costly_product desc
limit 3

-- 7] most costly product of each sub category,top 3
select product,sub_category,max(market_price) as costly_product from big_basket
group by 1,2
order by costly_product desc
limit 3
 
 -- 8] most discounted price product name
select product, (market_price-sale_price) as discount_price from big_basket
order by discount_price desc
limit 5

-- 9] which top 10  brand has most product

select brand ,count(product) as product_count  from big_basket
group by brand
order by product_count desc
limit 10

-- 10] printing top subcategories with =5 rating 
select category,sub_category,count(sub_category) as subcategory_count,rating  from big_basket
where rating = 5
group by 1,2,4
order by 3 desc
limit 3

-- 11] The top 3 sub-categories(rating = 1.0)
select category,sub_category,count(sub_category) as subcategory_count,rating  from big_basket
where rating = 1
group by 1,2,4
order by 3 desc
 
--  12] printing top types with rating 5.0 for top sub categories
select distinct (sub_category),type,count(type) as type_count,rating from big_basket
where rating = 5
group by 1,2,4
order by 3 desc

-- 13] printing top types with rating 1.0 for top sub categories
select distinct (sub_category),type,count(type) as type_count,rating from big_basket
where rating = 1
group by 1,2,4
order by 3 desc

-- 14] most discounted product of each category
with discount_category as(
select product,category,(market_price-sale_price) as discount_price ,
dense_rank() over(partition by category order by (market_price-sale_price) desc) as rank_number
from big_basket )
select * from discount_Category
where rank_number  between 1 and 3
order by discount_price desc

-- 15] top 3  most discounted percentage of each category
select* from(
select category,market_price,sale_price,
round(((market_price-sale_price)/market_price)*100,2) as discount_percentage ,   
dense_rank() over(partition by category order by ((market_price-sale_price)/market_price)*100 desc) as discount_percentage_rank 
from big_basket ) as discount_Category
where discount_percentage_rank between 1 and 3
order by (discount_percentage) desc
 