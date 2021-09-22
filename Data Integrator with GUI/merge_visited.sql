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

.output stdout