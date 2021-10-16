.mode csv
.headers on
.import output/finalData.csv records

.output output/finalData.csv


SELECT  *, datetime(unixTime/1000, 'unixepoch', 'localtime') AS date
FROM records;

.output stdout