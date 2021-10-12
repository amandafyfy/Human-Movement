.mode csv
.headers on
.import output/finalData.csv record_visited_loc
.import output/output_garmin.csv garmin

.output output/finalData.csv

UPDATE garmin
SET time = STRFTIME("%Y-%m-%d, %H:%M", time);


SELECT loc.*, G.latitude AS garmin_lat, G.longitude AS garmin_long, G.altitude AS garmin_alt, loc.latitude - G.latitude AS lat_dif, loc.longitude - G.longitude AS lon_dif
FROM record_visited_loc AS loc
LEFT JOIN garmin AS G
    ON G.time = STRFTIME("%Y-%m-%d, %H:%M", loc.date) ;

.output stdout