.mode csv
.headers on
.import output/finalData.csv records
.import data/visited_places_formatted.csv visitedPlaces

.output output/finalData.csv

SELECT R.*, VP.latitude AS vis_lat, VP.longitude AS vis_long,
VP.locationName AS vis_locName, VP.transport AS vis_transport,
VP."Activity 1" AS vis_act1, VP.Enjoyment1 AS vis_act_enjoyment1,
VP."Activity 2" AS vis_act2, VP.Enjoyment2 AS vis_act_enjoyment2,
VP."Activity 3" AS vis_act3, VP.Enjoyment3 AS vis_act_enjoyment3,
VP.Comment AS vis_comment
FROM records AS R
LEFT JOIN visitedPlaces AS VP
    ON ROUND(R.latitude,4) = ROUND(VP.latitude,4)
        AND ROUND(R.longitude,4) = ROUND(VP.longitude,4);

.output stdout
