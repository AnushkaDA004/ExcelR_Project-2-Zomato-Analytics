# Check Table and Database 
use zomato;
select * from main;
select * from calender;
select * from country;
show tables;

#Q.1 BUILD CONNECTIONS
#Connenction --- Main(year_&_date) to Calender(Datekey)
ALTER TABLE zomato.main
ADD CONSTRAINT fk_main_calendar
FOREIGN KEY (`year_&_date`) 
REFERENCES zomato.calender(Datekey);

#Connenction --- Main(currency) to Calender(currency)
ALTER TABLE zomato.main 
MODIFY COLUMN Currency VARCHAR(100);

ALTER TABLE zomato.main
ADD CONSTRAINT fk_main_currency
FOREIGN KEY (Currency) 
REFERENCES zomato.currency(Currency);

#Connenction --- Main(CountryCode) to COUNTRT(CountryID)
ALTER TABLE ZOMATO.MAIN
ADD CONSTRAINT fk_main_country
FOREIGN KEY (COUNTRYCODE)
REFERENCES ZOMATO.COUNTRY(COUNTRYID);

# 2.Find the Numbers of Resturants based on City and Country.
SELECT 
    c.CountryName, 
    m.City, 
    COUNT(m.`RestaurantID`) AS total_restaurants
FROM zomato.main m
INNER JOIN zomato.country c ON m.`CountryCode` = c.CountryID
GROUP BY c.CountryName, m.City 
ORDER BY total_restaurants DESC 
LIMIT 10;

# 3.Numbers of Resturants opening based on Year , Quarter , Month.
USE zomato;
-- Restaurants opening by Year
SELECT
    c.Year,
    COUNT(m.RestaurantID) AS Total_Restaurants
FROM main m
JOIN calender c
    ON m.`year_&_date` = c.Datekey
GROUP BY c.Year
ORDER BY c.Year;

-- Restaurants opening by Quarter
SELECT
    c.Quarter,
    COUNT(m.RestaurantID) AS Total_Restaurants
FROM main m
JOIN calender c
ON m.`year_&_date` = c.Datekey
GROUP BY c.Quarter
ORDER BY c.Quarter;

-- Restaurants opening by Month
SELECT
    c.Month_No,
    c.Month_Full_Name,
    COUNT(m.RestaurantID) AS Total_Restaurants
FROM main m
JOIN calender c
ON m.`year_&_date` = c.Datekey
GROUP BY c.Month_No, c.Month_Full_Name
ORDER BY c.Month_No;

# 4. Count of Resturants based on Average Ratings
SELECT
    CASE
        WHEN Rating < 2 THEN '0-2'
        WHEN Rating < 3 THEN '2-3'
        WHEN Rating < 4 THEN '3-4'
        ELSE '4-5'
    END AS Rating_Bucket,
    COUNT(RestaurantID) AS Total_Restaurants
FROM main
GROUP BY Rating_Bucket
ORDER BY Rating_Bucket;

# 5. Create buckets based on Average Price of reasonable size 
# and find out how many resturants falls in each buckets
SELECT
    CASE
        WHEN Cost_in_USD < 10 THEN 'Affordable'
        WHEN Cost_in_USD < 25 THEN 'Budget'
        WHEN Cost_in_USD < 50 THEN 'Mid-Range'
        WHEN Cost_in_USD < 100 THEN 'Premium'
        ELSE 'Luxury'
    END AS Price_Bucket,
    COUNT(RestaurantID) AS Total_Restaurants
FROM main
GROUP BY Price_Bucket
ORDER BY Total_Restaurants DESC;

# 6.Percentage of Resturants based on "Has_Table_booking"
-- yes count / total res count * 100 ---->  has table book
-- No count / total res count * 100 ---->  has table is not  book
select  Has_Table_booking,
		concat( round(booking_count / sum(booking_count) over () * 100  , 2)  , " ", "%")	as `% Booking`
from (	select  Has_Table_booking, 
				count(restaurantId) as booking_count 
		from main
		group by Has_Table_booking) as t1 ;

# 7.Percentage of Resturants based on "Has_Online_delivery"

select  Has_Online_delivery,
		concat(  round(	rest_count / sum(rest_count) over () * 100 , 2), "%") as `% Deliver `
from (  select Has_Online_delivery, 
			   count(restaurantId) as Rest_count 
		from main 
		group by Has_Online_delivery) as t1 ;

# 8. Find the Average Rating and Total Restaurants based on Price Range Segments.
SELECT Price_range,
       ROUND(AVG(Rating), 2) AS Avg_Rating,
       COUNT(RestaurantID) AS Total_Restaurants
FROM main
GROUP BY Price_range;

# 9. What are the top 10 most common cuisines offered across all cities, and what is their average rating?
select Cuisines, count(RestaurantID) as Restaurant_count, round(avg(Rating), 2) as Rating_Avg from main
group by Cuisines
order by Restaurant_count desc
limit 10;

# 10. Top 10 High-Rating Restaurants (Rating >= 4.5) with Low Customer Engagement (Votes < 50) 
alter table main modify column Rating decimal(5,1) ;
select RestaurantID, RestaurantName, rating, Votes from main 
where rating >= 4.5 and Votes < 50
order by rating desc
limit 10;

