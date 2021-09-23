.mode csv
.headers on
.import output/finalData.csv records
.import data/visited_places.csv visitedPlaces

.output output/finalData.csv

SELECT R.*, VP.locationName AS vis_name, 
        VP.Activity1 AS vis_activity1, VP.Activity2 AS vis_activity2, VP.Activity3 AS vis_activity3, 
        VP.latitude AS vis_lat, VP.longitude AS vis_long
FROM records AS R
LEFT JOIN visitedPlaces AS VP
    ON ROUND(R.latitude,4) = ROUND(VP.latitude,4)
        AND ROUND(R.longitude,4) = ROUND(VP.longitude,4);
 
SELECT speed, 
 CASE
           WHEN speed >= 25 AND speed <= 28 THEN 'Bus'
           when speed >= 13 AND speed <= 25 THEN 'Car'
           when speed >= 1.5 AND speed <= 2.5 THEN 'Walk'
           when speed >= 2.5 AND speed <= 4.1 THEN'Running'
           ELSE  
                'Train'
           END AS 'mode_of_transport'
FROM records;

.output stdout
