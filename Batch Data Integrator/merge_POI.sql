.mode csv
.headers on
.import output/finalData.csv record_visited
.import data/point_of_interest.csv POI

.output output/finalData.csv

SELECT R.*, P.locationName AS poi_name, P.latitude AS poi_lat, P.longitude AS poi_long
FROM record_visited AS R
LEFT JOIN 
    POI AS P    
    ON ROUND(R.latitude,4) = ROUND(P.latitude,4)
        AND ROUND(R.longitude,4) = ROUND(P.longitude,4);

.output stdout