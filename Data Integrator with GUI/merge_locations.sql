.mode csv
.headers on
.import output/finalData.csv record_visited
.import data/locations.csv locations

.output output/finalData.csv

UPDATE record_visited
SET latitude = ROUND(latitude,4),
    longitude = ROUND(longitude,4),
    date = STRFTIME('%Y-%m-%d, %H:%M', date);
UPDATE locations
SET latitude = ROUND(latitude,4),
    longitude = ROUND(longitude,4);

SELECT RV.*, L.locationName
FROM record_visited AS RV
LEFT JOIN 
    locations AS L
    ON RV.latitude = L.latitude AND RV.longitude = L.longitude;

.output stdout