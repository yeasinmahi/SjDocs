select top 100 * from dbo.Event   order by 2 desc
select top 1000 * from dbo.CardAccess order by 1 desc

SELECT 
  COUNT(1) AS totalSec,
  SUM(records_created_per_second) AS totalRecords,
  AVG(records_created_per_second) AS AvgRecordInsert
FROM (
  SELECT 
    FORMAT(createdat, 'yyyy-MM-dd HH:mm:ss') AS timestamp,
    COUNT(*) AS records_created_per_second
  FROM 
    dbo.Event
  WHERE 
    eventTime BETWEEN '2024-03-14 15:00:00' AND '2024-03-15 03:00:01'
  GROUP BY 
    FORMAT(createdat, 'yyyy-MM-dd HH:mm:ss')
) AS subquery;




select top 100 * from dbo.Event   order by 1 desc


select assetId, equipmentType, count(1) 
from dbo.CardAccess 
group by assetId,equipmentType
order by 3 desc

select top 100 * from CardAccess i join dbo.Event e on e.assetid= i.assetId

select count(1) from dbo.Event

select count(1) from dbo.CardAccess

select * from dbo.Event where eventTime> '2023-12-31' order by 2
select * from dbo.Event where eventTime< '2023-01-20' order by 2 

select count(1) from dbo.Event where eventTime> '2023-12-31' 
select count(1) from dbo.Event where eventTime< '2023-01-20' 

--delete from  dbo.Event  where eventTime> '2023-12-31' or eventTime< '2023-01-20'

INSERT INTO dbo.dirtydata_event SELECT * FROM dbo.Event where eventTime> '2023-12-31' or eventTime< '2023-01-20'

select * from dbo.event where eventTime BETWEEN '2023-02-13' AND '2023-02-14'

select eventTime,cardid,assetid,count(1) as total from dbo.Event 
group by eventTime,cardid,assetid
having count(1)>1

with duplicateEvents as (
    select *,ROW_NUMBER() over (PARTITION by eventTime,cardid,assetid order by eventTime,cardid,assetid) as rownumber from Event 
)
select * from duplicateEvents where rownumber>1


select eventtype, count(1) from dbo.Event group by eventtype

select * from dbo.Event where eventId between 1121000 and 1120000

select * from dbo.Event where eventtime = '2023-01-20 10:43:57' and assetid = '053-005-001-000'

select cardid, count(1) from Event GROUP by cardid order by 2 desc

select eventtype, count(1) from Event GROUP by eventtype order by 2 desc

select top 100 * from dbo.Event 

--truncate table dbo.CardAccess
--truncate table dbo.Event


select count(1) from dbo.event_bak ;

--Select * INTO dbo.event_bak FROM dbo.Event

-- delete from Event where eventId = 8115

CREATE NONCLUSTERED INDEX [Event_cardid_time_type] ON [dbo].[Event] ([assetid]) INCLUDE ([cardid], [eventTime], [eventtype]) WITH (ONLINE = ON)

