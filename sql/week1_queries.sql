
-- Lab 4, Query 1: View 10 rows
SELECT *
FROM raw_flights
LIMIT 10;


-- Lab 4, Query 2: Count flight records
SELECT COUNT(*) AS total_rows
FROM raw_flights;


-- Lab 4, Query 3: Join flights with airline names
SELECT
    a.airline AS airline_name,
    COUNT(*) AS flights,
    ROUND(AVG(f.departure_delay), 2) AS avg_departure_delay
FROM raw_flights f
LEFT JOIN raw_airlines a
    ON f.airline = a.iata_code
GROUP BY a.airline
ORDER BY avg_departure_delay DESC;


-- Lab 4, Query 4: CSV baseline
SELECT airline, AVG(departure_delay) AS avg_delay
FROM raw_flights
GROUP BY airline
ORDER BY avg_delay DESC;


-- Lab 4, Part C: Convert CSV to Parquet
CREATE TABLE flights_db.flights_parquet
WITH (
    format = 'PARQUET',
    parquet_compression = 'SNAPPY',
    external_location = 's3://priyamore-de-lake-12345/curated/flights_parquet/'
) AS
SELECT *
FROM flights_db.raw_flights;


-- Lab 4, Part C: Query Parquet
SELECT airline, AVG(departure_delay) AS avg_delay
FROM flights_parquet
GROUP BY airline
ORDER BY avg_delay DESC;
