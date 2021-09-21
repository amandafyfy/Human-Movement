.mode csv
.headers on
.import output/finalData.csv records
.import data/visited_places.csv visitedPlaces

.output output/finalData.csv

UPDATE records
SET latitude = ROUND(latitude,4),
    longitude = ROUND(longitude,4),
    date = STRFTIME('%Y-%m-%d, %H:%M', date);

UPDATE visitedPlaces
SET latitude = ROUND(latitude,4),
    longitude = ROUND(longitude,4);

SELECT R.*, VP.locationName AS locationName_vis, VP.Activity1, VP.Activity2, VP.Activity3
FROM records AS R
LEFT JOIN visitedPlaces AS VP
    ON R.latitude = VP.latitude 
        AND R.longitude = VP.longitude;


/* 
SELECT  id, date, speed, lat4, long4,
        visitedPlaces.locationName, visitedPlaces.Activity1, visitedPlaces.Activity2,
        visitedPlaces.Activity3
FROM (SELECT *, ROUND(records.latitude,4) AS lat4 , ROUND(records.longitude,4) AS long4 FROM records) AS records
LEFT JOIN 
    (SELECT ROUND(visitedPlaces.latitude,4) AS lat4_vis , 
        ROUND(visitedPlaces.longitude,4) AS long4_vis, 
        visitedPlaces.id AS id_vis, 
        visitedPlaces.longitude AS long_vis, 
        visitedPlaces.latitude AS lat_vis,
        visitedPlaces.locationName, visitedPlaces.Activity1, visitedPlaces.Activity2,
        visitedPlaces.Activity3

    FROM visitedPlaces) as visitedPlaces
    ON lat4 = lat4_vis AND long4 = long4_vis AND id = id_vis;
*/
.output stdout