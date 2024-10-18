---------Feedback-------------
select top 100 * from dbo.ToiletFeedback order by 3 desc

select  count(1) from dbo.ToiletFeedback

---------PeopleCount-------------

select top 1000 * from dbo.PeopleCount order by 3 desc

select * from dbo.PeopleCount order by 1 desc


select  count(1) from dbo.PeopleCount

select  date, count(1) from dbo.PeopleCount 
group by date
order by 1 desc

select distinct(location_name) FROM PeopleCount

select * FROM PeopleCount where location_name is null

SELECT location_name 
FROM PeopleCount 
WHERE date = '2024-02-27'
AND location_name NOT IN (
    SELECT location_name 
    FROM PeopleCount 
    WHERE date = '2024-03-04'
);

select * FROM PeopleCount where date = '2024-01-02' and location_id = '1721'

select date, sum(total) total_traffic, count(1) No_Of_loation FROM PeopleCount group by date order by 1 desc

select location_id,date, count(1) FROM PeopleCount 
group by location_id,date
order by 2 desc


WITH MaxCountPerLocationDate AS (
  SELECT
    location_id,
    date,
    MAX(total) AS max_count
  FROM
    PeopleCount
  GROUP BY
    location_id, date
)
Delete pc
FROM PeopleCount pc
JOIN MaxCountPerLocationDate mcpld
ON pc.location_id = mcpld.location_id
   AND pc.date = mcpld.date
   AND pc.total < mcpld.max_count;

WITH DuplicateRows AS (
  SELECT
    location_id,
    date,
    total,
    ROW_NUMBER() OVER (PARTITION BY location_id, date ORDER BY total DESC) AS RowNum
  FROM
    PeopleCount
)
delete FROM DuplicateRows  WHERE RowNum > 1;

SELECT
    location_id,
    date,
    MAX(total) AS max_count
  FROM
    PeopleCount
  GROUP BY
    location_id, date
    having count(1)>1

-- TRUNCATE table PeopleCount
-- TRUNCATE table ToiletFeedback

delete from PeopleCount where date = '2023-12-31' 

select * into PeopleCount_bak2 from PeopleCount

IF NOT EXISTS(SELECT * FROM ToiletFeedback WHERE fid = '108T' and local_timestamp = '2023-06-28 23:57:00') INSERT INTO ToiletFeedback (fid, rating, local_timestamp, No_Soap, No_Toilet_Paper, Bin_is_Full, Dirty_Basin, Wet_Floor, Smelly_CubicleUrinal, Faulty_Door, Faulty_Flush, location) VALUES (@fid, @rating, @local_timestamp, @No_Soap, @No_Toilet_Paper, @Bin_is_Full, @Dirty_Basin, @Wet_Floor, @Smelly_CubicleUrinal, @Faulty_Door, @Faulty_Flush, @location)

IF NOT EXISTS(SELECT * FROM PeopleCount WHERE location_id = '1564' and date = '2023-06-28') INSERT INTO PeopleCount (location_id, Date, H0, H1, H2, H3, H4, H5, H6, H7, H8, H9, H10, H11, H12, H13, H14, H15, H16, H17, H18, H19, H20, H21, H22, H23, peak_hour, Total, location_name) VALUES (@location_id, @Date, @H0, @H1, @H2, @H3, @H4, @H5, @H6, @H7, @H8, @H9, @H10, @H11, @H12, @H13, @H14, @H15, @H16, @H17, @H18, @H19, @H20, @H21, @H22, @H23, @peak_hour, @Total, @location_name) else UPDATE PeopleCount SET location_id = @location_id, Date = @Date, H0 = @H0, H1 = @H1, H2 = @H2, H3 = @H3, H4 = @H4, H5 = @H5, H6 = @H6, H7 = @H7, H8 = @H8, H9 = @H9, H10 = @H10, H11 = @H11, H12 = @H12, H13 = @H13, H14 = @H14, H15 = @H15, H16 = @H16, H17 = @H17, H18 = @H18, H19 = @H19, H20 = @H20, H21 = @H21, H22 = @H22, H23 = @H23, peak_hour = @peak_hour, Total = @Total, location_name = @location_name WHERE location_id = '1564' and date = '2023-06-28'

CREATE NONCLUSTERED INDEX [PeopleCount_locationid_date] ON [dbo].[PeopleCount] ([location_id]) INCLUDE ([date])  WITH (ONLINE = ON)

