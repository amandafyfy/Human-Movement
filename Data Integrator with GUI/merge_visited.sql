.mode csv
.headers on
.import output/finalData.csv records
.import data/visited_places.csv visitedPlaces

.output output/finalData.csv

SELECT R.*, VP.locationName AS vis_name, 
        VP.Activity1, VP.Activity2, VP.Activity3, 
        VP.latitude AS lat_vis, VP.longitude AS long_vis
FROM records AS R
LEFT JOIN visitedPlaces AS VP
    ON ROUND(R.latitude,4) = ROUND(VP.latitude,4)
        AND ROUND(R.longitude,4) = ROUND(VP.longitude,4);

.output stdout