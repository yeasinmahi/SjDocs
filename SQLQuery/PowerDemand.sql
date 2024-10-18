select * from PowerDemand

delete from PowerDemand
where date< '2022-11-07'

select max(EnergyConsumption) as max, 
min(EnergyConsumption) as min, 
avg(EnergyConsumption) as avg,
avg (CASE WHEN DATEPART(HOUR, [date]) > 8 AND DATEPART(HOUR, [date]) < 18 THEN EnergyConsumption end) as avg_officehour
from PowerDemand

-- TRUNCATE table PowerDemand

drop table PowerDemand


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PowerDemand](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[date] [datetime] NULL,
	[EnergyConsumption] [bigint] NULL,
	[CreatedAt] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PowerDemand] ADD  CONSTRAINT [PK_PowerDemand] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PowerDemand] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO

