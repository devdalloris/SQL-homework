create database class13;
go
use class13;
go

declare @InputDate date ='2025-03-14';
;with cte as(
	 select 
		DATEFROMPARTS(Year(@InputDate), Month(@InputDate), 1) as [Date],
		DATENAME(Weekday, DATEFROMPARTS(Year(@InputDate), Month(@InputDate), 1)) as WeekDayName,
		DATEPART(Weekday, DATEFROMPARTS(Year(@InputDate), Month(@InputDate), 1)) as WeekdayNum,
		1 as weeknumber
		Union all

		select DATEADD(day, 1, [date]),
		DATENAME(weekday, DateAdd(day, 1, [date])),
		DATEPART(weekday, DATEADD(day, 1, [date])),
		case 
			when datePart(weekday, DATEADD(day, 1, [date]))>weekdayNum then weeknumber else weeknumber+1
		end
		from cte
		where [date]<EOMONTH(@inputdate)


)
select 
max(case when weekdayname = 'Sunday' then day(date) end) as Sunday,
max(case when weekdayname = 'Monday' then day(date) end) as Monday,
max(case when weekdayname = 'Tuesday' then day(date) end) as Tuesday,
max(case when weekdayname = 'Wednesday' then day(date) end) as Wednesday,
max(case when weekdayname = 'Thursday' then day(date) end) as Thursday,
max(case when weekdayname = 'Friday' then day(date) end) as Friday,
max(case when weekdayname = 'Saturday' then day(date) end) as Saturday
from cte
group by weeknumber