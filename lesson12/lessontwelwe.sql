--Homework12


Declare @todate datetime, @fromdate datetime
set @fromdate = '2025-01-01'
set @todate = '2025-12-31'
 
;With DateSequence( [Date] ) as
(	Select @fromdate as [Date]
        union all
    Select dateadd(day, 1, [Date]) from DateSequence where Date < @todate
)
select 
	cast(convert(varchar, [Date], 112) as int) as ID, 
	*, 
	datepart(day, [Date]) as [Day],
	case when format([Date], 'dd') like '%1' and format([Date], 'dd') not like '%11'   then format([Date], 'dd') + 'st' 
		when format([Date], 'dd') like '%2' and format([Date], 'dd') not like '%12' then format([Date], 'dd') + 'nd'
		when format([Date], 'dd') like '%3' and format([Date], 'dd') not like '%13' then format([Date], 'dd') + 'rd'
		else format([Date], 'dd') + 'th'
		end as DaySuffix,
	format([Date], 'dddd') as DayOfWeek,
	datediff(day, '2024-12-31', [Date]) as DayOfYear,
	datepart(week, [Date]) as WeekOfYear,
	(datediff(day, dateadd(month, datediff(month, 0, [Date]), 0), [Date]) / 7) + 1 as WeekOfMonth,
	datepart(month, [Date]) as Month,
	format([Date], 'MMMM') as MonthDate,
	case when datepart(month, [Date]) in (1, 2, 3) then '1' 
		when datepart(month, [Date]) in (4, 5, 6) then '2'
		when datepart(month, [Date]) in (7, 8, 9) then '3' else '4' end as Quarter,
	case when datepart(month, [Date]) in (1, 2, 3) then 'First' 
		when datepart(month, [Date]) in (4, 5, 6) then 'Second'
		when datepart(month, [Date]) in (7, 8, 9) then 'Third' else 'Fourth' end as QuarterName,
	datepart(year, [Date]) as Year
from DateSequence option (maxrecursion 365)




