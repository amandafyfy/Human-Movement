.mode csv
.headers on
.import output/finalData.csv records

.output output/finalData.csv

SELECT userId, unixTime, datetime(unixTime/1000, 'unixepoch', 'localtime') AS date, latitude, longitude, speed,
CASE
	WHEN CAST(speed as DECIMAL(9,2)) = 0 THEN 'Stationary'
	WHEN CAST(speed as DECIMAL(9,2)) > 0 AND CAST(speed as DECIMAL(9,2)) <= 2.7 THEN 'Walking'
	WHEN CAST(speed as DECIMAL(9,2)) > 2.7 AND CAST(speed as DECIMAL(9,2)) <= 3.6 THEN 'Running'
	WHEN CAST(speed as DECIMAL(9,2)) > 3.6 AND CAST(speed as DECIMAL(9,2)) <= 6.9 THEN'E-scooter'
	WHEN CAST(speed as DECIMAL(9,2)) > 6.9 AND CAST(speed as DECIMAL(9,2)) <= 11.1 THEN 'Cycling'
	WHEN CAST(speed as DECIMAL(9,2)) > 11.1 AND CAST(speed as DECIMAL(9,2)) <= 19.2 THEN 'Car'
	WHEN CAST(speed as DECIMAL(9,2)) > 19.2 AND CAST(speed as DECIMAL(9,2)) <= 20.0 THEN 'Bus'
	WHEN CAST(speed as DECIMAL(9,2)) > 20.0 AND CAST(speed as DECIMAL(9,2)) <= 36.0 THEN 'Train'
	ELSE 'UNKNOWN'
END AS 'mode_of_transport'
FROM records
ORDER BY userId, unixTime;

.output stdout