.mode csv
.headers on
.import output/finalData.csv records

.output output/finalData.csv

UPDATE records
SET unixTime = datetime(unixTime/1000, 'unixepoch', 'localtime');

SELECT * FROM records;

.output stdout