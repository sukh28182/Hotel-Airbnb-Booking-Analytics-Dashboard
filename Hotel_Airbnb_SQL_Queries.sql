CREATE DATABASE hotel_airbnb_analytics;
use hotel_airbnb_analytics;

 -- Query 1: Total Number of Bookings -- 
SELECT COUNT(*) AS Total_Bookings
FROM booking;

 -- Query 2: Total Revenue -- 
SELECT ROUND(SUM(total_amount),2) AS Total_Revenue
FROM payment;

 -- Query 3: Total Customers -- 
SELECT COUNT(*) AS Total_Customers
FROM customer;

 -- Query 4: Total Properties -- 
 SELECT COUNT(*) AS Total_Properties
 FROM property;

 -- Query 5: Revenue by Property Type -- 
SELECT b.property_type, ROUND(SUM(p.total_amount),2) AS Revenue
FROM booking b
JOIN payment p
ON b.booking_id = p.booking_id
GROUP BY b.property_type
ORDER BY Revenue DESC;

 -- Query 6: Bookings by City -- 
SELECT city, COUNT(*) AS Total_Bookings
FROM booking
GROUP BY city
ORDER BY Total_Bookings DESC;

 -- Query 7: Revenue by City -- 
SELECT b.city, ROUND(SUM(p.total_amount),2) AS Revenue
FROM booking b
JOIN payment p
ON b.booking_id = p.booking_id
GROUP BY b.city
ORDER BY Revenue DESC;

 -- Query 8: Booking Status Distribution -- 
SELECT booking_status, COUNT(*) AS Total
FROM booking
GROUP BY booking_status
ORDER BY Total DESC;

 -- Query 9: Payment Status Distribution -- 
SELECT payment_status, COUNT(*) AS Total
FROM payment
GROUP BY payment_status;

 -- Query 10: Most Preferred Room Type -- 
SELECT room_type, COUNT(*) AS Total_Bookings
FROM booking
GROUP BY room_type
ORDER BY Total_Bookings DESC;

 -- Query 11: Top 10 Highest Revenue Cities -- 
SELECT b.city, ROUND(SUM(p.total_amount),2) AS Revenue
FROM booking b
JOIN payment p
ON b.booking_id = p.booking_id
GROUP BY b.city
ORDER BY Revenue DESC
LIMIT 10;

 -- Query 12: Seasonal Booking Analysis -- 
SELECT season, COUNT(*) AS Total_Bookings
FROM booking
GROUP BY season
ORDER BY Total_Bookings DESC;

 -- Query 13: Purpose of Visit Analysis -- 
SELECT purpose_of_visit, COUNT(*) AS Total_Bookings
FROM booking
GROUP BY purpose_of_visit
ORDER BY Total_Bookings DESC;

 -- Query 14: Average Booking Lead Time -- 
SELECT ROUND(AVG(booking_lead_time),2) AS Avg_Lead_Time
FROM booking;

 -- Query 15: Average Rating -- 
SELECT ROUND(AVG(rating),2) AS Average_Rating
FROM review;

 -- Query 16: Top 10 Highest Spending Customers -- 
SELECT c.customer_name, ROUND(SUM(p.total_amount),2) AS Total_Spent
FROM customer c
JOIN booking b ON c.customer_id = b.customer_id
JOIN payment p ON b.booking_id = p.booking_id
GROUP BY c.customer_name
ORDER BY Total_Spent DESC
LIMIT 10;

 -- Query 17: Average Revenue by City -- 
SELECT b.city, ROUND(AVG(p.total_amount),2) AS Average_Revenue
FROM booking b
JOIN payment p ON b.booking_id = p.booking_id
GROUP BY b.city
ORDER BY Average_Revenue DESC;

 -- Query 18: Most Popular Booking Source -- 
SELECT booking_source, COUNT(*) AS Total_Bookings
FROM booking
GROUP BY booking_source
ORDER BY Total_Bookings DESC;

 -- Query 19: Average Stay Duration by Property Type -- 
SELECT property_type, ROUND(AVG(total_nights),2) AS Average_Stay
FROM booking
GROUP BY property_type;

 -- Query 20: Top 5 Cities by Booking Count -- 
SELECT city, COUNT(*) AS Total_Bookings
FROM booking
GROUP BY city
ORDER BY Total_Bookings DESC
LIMIT 5;

 -- Query 21: Customers with More Than 5 Bookings -- 
SELECT c.customer_name, COUNT(b.booking_id) AS Total_Bookings
FROM customer c
JOIN booking b
ON c.customer_id = b.customer_id
GROUP BY c.customer_name
HAVING COUNT(b.booking_id) > 5
ORDER BY Total_Bookings DESC;

 -- Query 22: Revenue Generated in Each Season -- 
SELECT b.season, ROUND(SUM(p.total_amount),2) AS Revenue
FROM booking b
JOIN payment p
ON b.booking_id = p.booking_id
GROUP BY b.season
ORDER BY Revenue DESC;

 -- Query 23: Average Rating by Property Type -- 
SELECT b.property_type, ROUND(AVG(r.rating),2) AS Average_Rating
FROM booking b
JOIN review r
ON b.booking_id = r.booking_id
GROUP BY b.property_type;

 -- Query 24: Weekend vs Weekday Bookings -- 
SELECT is_weekend, COUNT(*) AS Total_Bookings
FROM booking
GROUP BY is_weekend;

 -- Query 25: Payment Method Analysis -- 
SELECT payment_method, COUNT(*) AS Total_Payments,
ROUND(SUM(total_amount),2) AS Revenue
FROM payment
GROUP BY payment_method
ORDER BY Revenue DESC;

 -- Query 26: Rank Cities by Revenue -- 
SELECT b.city, ROUND(SUM(p.total_amount),2) AS Revenue,
RANK() OVER (ORDER BY SUM(p.total_amount) DESC) AS Revenue_Rank
FROM booking b
JOIN payment p
ON b.booking_id = p.booking_id
GROUP BY b.city;

 -- Query 27: Top 3 Highest Spending Customers -- 
SELECT * FROM (
    SELECT c.customer_name,
        ROUND(SUM(p.total_amount),2) AS Total_Spent,
        ROW_NUMBER() OVER (ORDER BY SUM(p.total_amount) DESC) AS Rank_No
    FROM customer c
    JOIN booking b
        ON c.customer_id = b.customer_id
    JOIN payment p
        ON b.booking_id = p.booking_id
    GROUP BY c.customer_name
) AS ranked_customers
WHERE Rank_No <= 3;

 -- Query 28: Cities with Above Average Revenue -- 
WITH CityRevenue AS (
    SELECT b.city, ROUND(SUM(p.total_amount),2) AS Revenue
    FROM booking b
    JOIN payment p
        ON b.booking_id = p.booking_id
    GROUP BY b.city
)

SELECT *
FROM CityRevenue
WHERE Revenue > (SELECT AVG(Revenue) FROM CityRevenue);

 -- Query 29: Properties Earning More Than Average Revenue -- 
SELECT b.property_type,
    ROUND(SUM(p.total_amount),2) AS Revenue
FROM booking b
JOIN payment p
ON b.booking_id = p.booking_id
GROUP BY b.property_type
HAVING SUM(p.total_amount) > (SELECT AVG(total_amount) FROM payment);

 -- Query 30: Running Total Revenue -- 
SELECT booking_id, total_amount,
	SUM(total_amount)
    OVER (ORDER BY booking_id) AS Running_Total
FROM payment;

SELECT COUNT(DISTINCT customer_id) FROM customer;