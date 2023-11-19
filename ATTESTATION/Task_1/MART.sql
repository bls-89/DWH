--Нужно заполнить год - где его нет из времени старта:
UPDATE austin_bikeshare_trips 
SET year = EXTRACT(YEAR FROM start_time)
WHERE year IS NULL;

CREATE VIEW MART_2013 AS 
WITH start_station as(
SELECT  start_station_id, year, AVG(duration_minutes)as avg_duration_start_trip, COUNT(start_station_id) as count_start_trip
FROM austin_bikeshare_trips a  
INNER JOIN austin_bikeshare_stations b ON a.start_station_id = b.station_id
WHERE status = 'active'
GROUP by year,start_station_id
ORDER by avg_duration_start_trip),
end_station AS (
SELECT DISTINCT end_station_id, year, AVG(duration_minutes) as avg_duration_end_trip, COUNT(end_station_id) as count_end_trip
FROM austin_bikeshare_trips a  
INNER JOIN austin_bikeshare_stations b ON a.end_station_id = b.station_id
WHERE status = 'active'
GROUP by year,end_station_id
ORDER by avg_duration_end_trip)
SELECT COALESCE(start_station_id,end_station_id) as station_id, coalesce(count_start_trip, 0) as count_start_trip,coalesce(count_end_trip,0) as count_end_trip, (coalesce(count_start_trip, 0) + coalesce(count_end_trip,0)) as summary_count_trip,coalesce(avg_duration_start_trip,0) as avg_duration_start_trip,coalesce(avg_duration_end_trip,0) as avg_duration_end_trip
FROM (start_station ss FULL OUTER JOIN end_station es ON ss.start_station_id = es.end_station_id )
WHERE ss.year = 2013 and es.year=2013
ORDER BY avg_duration_start_trip

CREATE VIEW MART_2014 AS 
WITH start_station as(
SELECT  start_station_id, year, AVG(duration_minutes)as avg_duration_start_trip, COUNT(start_station_id) as count_start_trip
FROM austin_bikeshare_trips a  
INNER JOIN austin_bikeshare_stations b ON a.start_station_id = b.station_id
WHERE status = 'active'
GROUP by year,start_station_id
ORDER by avg_duration_start_trip),
end_station AS (
SELECT DISTINCT end_station_id, year, AVG(duration_minutes) as avg_duration_end_trip, COUNT(end_station_id) as count_end_trip
FROM austin_bikeshare_trips a  
INNER JOIN austin_bikeshare_stations b ON a.end_station_id = b.station_id
WHERE status = 'active'
GROUP by year,end_station_id
ORDER by avg_duration_end_trip)
SELECT COALESCE(start_station_id,end_station_id) as station_id, coalesce(count_start_trip, 0) as count_start_trip,coalesce(count_end_trip,0) as count_end_trip, (coalesce(count_start_trip, 0) + coalesce(count_end_trip,0)) as summary_count_trip,coalesce(avg_duration_start_trip,0) as avg_duration_start_trip,coalesce(avg_duration_end_trip,0) as avg_duration_end_trip
FROM (start_station ss FULL OUTER JOIN end_station es ON ss.start_station_id = es.end_station_id )
WHERE ss.year = 2014 and es.year=2014
ORDER BY avg_duration_start_trip

CREATE VIEW MART_2015 AS
WITH start_station as(
SELECT  start_station_id, year, AVG(duration_minutes)as avg_duration_start_trip, COUNT(start_station_id) as count_start_trip
FROM austin_bikeshare_trips a  
INNER JOIN austin_bikeshare_stations b ON a.start_station_id = b.station_id
WHERE status = 'active'
GROUP by year,start_station_id
ORDER by avg_duration_start_trip),
end_station AS (
SELECT DISTINCT end_station_id, year, AVG(duration_minutes) as avg_duration_end_trip, COUNT(end_station_id) as count_end_trip
FROM austin_bikeshare_trips a  
INNER JOIN austin_bikeshare_stations b ON a.end_station_id = b.station_id
WHERE status = 'active'
GROUP by year,end_station_id
ORDER by avg_duration_end_trip)
SELECT COALESCE(start_station_id,end_station_id) as station_id, coalesce(count_start_trip, 0) as count_start_trip,coalesce(count_end_trip,0) as count_end_trip, (coalesce(count_start_trip, 0) + coalesce(count_end_trip,0)) as summary_count_trip,coalesce(avg_duration_start_trip,0) as avg_duration_start_trip,coalesce(avg_duration_end_trip,0) as avg_duration_end_trip
FROM (start_station ss FULL OUTER JOIN end_station es ON ss.start_station_id = es.end_station_id )
WHERE ss.year = 2015 and es.year=2015
ORDER BY avg_duration_start_trip

CREATE VIEW MART_2016 AS
WITH start_station as(
SELECT  start_station_id, year, AVG(duration_minutes)as avg_duration_start_trip, COUNT(start_station_id) as count_start_trip
FROM austin_bikeshare_trips a  
INNER JOIN austin_bikeshare_stations b ON a.start_station_id = b.station_id
WHERE status = 'active'
GROUP by year,start_station_id
ORDER by avg_duration_start_trip),
end_station AS (
SELECT DISTINCT end_station_id, year, AVG(duration_minutes) as avg_duration_end_trip, COUNT(end_station_id) as count_end_trip
FROM austin_bikeshare_trips a  
INNER JOIN austin_bikeshare_stations b ON a.end_station_id = b.station_id
WHERE status = 'active'
GROUP by year,end_station_id
ORDER by avg_duration_end_trip)
SELECT COALESCE(start_station_id,end_station_id) as station_id, coalesce(count_start_trip, 0) as count_start_trip,coalesce(count_end_trip,0) as count_end_trip, (coalesce(count_start_trip, 0) + coalesce(count_end_trip,0)) as summary_count_trip,coalesce(avg_duration_start_trip,0) as avg_duration_start_trip,coalesce(avg_duration_end_trip,0) as avg_duration_end_trip
FROM (start_station ss FULL OUTER JOIN end_station es ON ss.start_station_id = es.end_station_id )
WHERE ss.year = 2016 and es.year=2016
ORDER BY avg_duration_start_trip

CREATE VIEW MART_2017 AS
WITH start_station as(
SELECT  start_station_id, year, AVG(duration_minutes)as avg_duration_start_trip, COUNT(start_station_id) as count_start_trip
FROM austin_bikeshare_trips a  
INNER JOIN austin_bikeshare_stations b ON a.start_station_id = b.station_id
WHERE status = 'active'
GROUP by year,start_station_id
ORDER by avg_duration_start_trip),
end_station AS (
SELECT DISTINCT end_station_id, year, AVG(duration_minutes) as avg_duration_end_trip, COUNT(end_station_id) as count_end_trip
FROM austin_bikeshare_trips a  
INNER JOIN austin_bikeshare_stations b ON a.end_station_id = b.station_id
WHERE status = 'active'
GROUP by year,end_station_id
ORDER by avg_duration_end_trip)
SELECT COALESCE(start_station_id,end_station_id) as station_id, coalesce(count_start_trip, 0) as count_start_trip,coalesce(count_end_trip,0) as count_end_trip, (coalesce(count_start_trip, 0) + coalesce(count_end_trip,0)) as summary_count_trip,coalesce(avg_duration_start_trip,0) as avg_duration_start_trip,coalesce(avg_duration_end_trip,0) as avg_duration_end_trip
FROM (start_station ss FULL OUTER JOIN end_station es ON ss.start_station_id = es.end_station_id )
WHERE ss.year = 2017 and es.year=2017
ORDER BY avg_duration_start_trip