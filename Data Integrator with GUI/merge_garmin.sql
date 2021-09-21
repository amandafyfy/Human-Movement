.mode csv
.headers on
.import output/finalData.csv record_visited_loc
.import data/output_garmin.csv garmin

.output output/finalData.csv

UPDATE record_visited_loc
SET latitude = ROUND(latitude,4),
    longitude = ROUND(longitude,4),
    date = STRFTIME('%Y-%m-%d, %H:%M', date);

UPDATE garmin
SET latitude = ROUND(latitude,4),
    longitude = ROUND(longitude,4),
    time = STRFTIME('%Y-%m-%d, %H:%M', time);


SELECT loc.*, G.latitude, G.longitude, G.altitude
FROM record_visited_loc AS loc
LEFT JOIN garmin AS G
    ON loc.date = G.time;

.output stdout