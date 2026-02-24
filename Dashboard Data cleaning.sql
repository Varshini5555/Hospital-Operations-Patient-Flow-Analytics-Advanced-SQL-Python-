/*1. cleaning hour_dashboard_snapshot table*/
/* To analyze the datatypes and null values in the dataset */
describe hour_dashboard_snapshot

SET SQL_SAFE_UPDATES = 0;

/*to remove Hours from each cell of the hours column*/
UPDATE hour_dashboard_snapshot
SET hour = REPLACE(hour, ' Hours', '');

SET SQL_SAFE_UPDATES = 1;

/*to change the hour column into integer*/
ALTER TABLE hour_dashboard_snapshot
MODIFY hour INT;

/*2. cleaning day_dashboard_snapshot table*/
/*Changing datatype of date column from text to date*/
SET SQL_SAFE_UPDATES = 0;

UPDATE day_dashboard_snapshot
SET date = STR_TO_DATE(date, '%d/%m/%Y');
ALTER TABLE day_dashboard_snapshot
MODIFY date DATE;

SET SQL_SAFE_UPDATES = 1;

/*checking if the datatype changes reflected on the table*/
describe day_dashboard_snapshot

select * from day_dashboard_snapshot