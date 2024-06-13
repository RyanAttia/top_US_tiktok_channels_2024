/*

# Data quality tests

1. The data needs to be 100 records of Tiktok channels (row count test)
2. The data needs 4 fields (column count test)
3. The channel name column must be string format, and the other columns must be numerical data types (datatype check)
4. Each record must be unique in the dataset (duplicate count check)

Row count - 100
Column count - 4

Data types
CHANNEL_NAME = VARCHAR
FOLLOWERS = INTEGER
TOTAL_VIEWS = INTEGER
UPLOADS = INTEGER

DUPLICATE COUNT = 0 
*/


/* 1. Row count Check*/
SELECT COUNT(*) as row_count
FROM view_us_tiktok_users_2024;


/* 2. Column count Check*/
SELECT COUNT(*) AS column_count FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'view_us_tiktok_users_2024';


/* 3. Datatype Check*/
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'view_us_tiktok_users_2024';


/* 4. Duplicate Count Check*/
SELECT CHANNEL_NAME, COUNT(*) AS DUPLICATE_COUNT
FROM view_us_tiktok_users_2024
GROUP BY CHANNEL_NAME HAVING COUNT(*) > 1;
