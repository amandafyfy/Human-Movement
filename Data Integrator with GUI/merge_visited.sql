.mode csv
.headers on
.import output/finalData.csv records
.import data/visited_places_formatted.csv visitedPlaces

.output output/finalData.csv

SELECT R.*, VP.latitude AS vis_lat, VP.longitude AS vis_long, VP.* FROM records AS R
LEFT JOIN visitedPlaces AS VP
    ON ROUND(R.latitude,4) = ROUND(VP.latitude,4)
        AND ROUND(R.longitude,4) = ROUND(VP.longitude,4);

.output stdout
