--On SAP VORA DB
--Some stats from METERS table

--select count(*) from METERS
--rows 568846365
--Min(TSTAMP) 2017-01-20 16:12:19.000
--Max(TSTAMP) 2018-02-16 00:54:27.000

select * from METERS limit 1000

--Some important table description
- power_phase_1 --> power on phase 1 as reported by the meter, in W * 10^-3
- power_phase_2  --> power on phase 2 as reported by the meter, in W * 10^-3
- power_phase_3 --> power on phase 3 as reported by the meter, in W * 10^-3
- energy --> energy from the grid to the meter, in kWh * 10^-10
- energy_out  --> energy from the meter to the grid, in kWh * 10^-10

--Exploring date intervals
select count(*) from METERS
where TSTAMP between '2017-01-01 00:00:00.000' and '2017-06-01 00:00:00.000'
rows: 93688493

--Count the reduction per minute with a filter by date interval (jan-june) in 2017
select count(*) from (
select 
    year(TSTAMP) as MYear,
    Month(TSTAMP) as MMonth, 
    dayofmonth(TSTAMP) as DDay,
    hour(TSTAMP) as HHour,
    minute(TSTAMP) as MMinute,
    max(Power_all) as PowerAll,
    max(power_phase_1) as PPowerPhase1,
    max(power_phase_2) as PPowerPhase2,
    max(power_phase_3)  as PPowerPhase3
from METERS 
where TSTAMP between '2017-01-01 00:00:00.000' and '2017-06-01 00:00:00.000'
group by
    MYear,
    MMonth, 
    DDay,
    HHour,
    MMinute
) tab
rows: 141649    




--SELECT [Date]
--  FROM [FRIIB].[dbo].[ArchiveAnalog]
 -- GROUP BY [Date], date(hh, [Date])



--Count different sensors
select 
    METERID,
    COUNT(*)
from METERS 
group by
    METERID
