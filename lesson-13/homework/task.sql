
create function dbo.calendar_maker 
(
@monthh date
)
returns 
@calendar table
(
	sunday int,
	monday int,
	tuesday int,
	wednesday int,
	thursday int,
	friday int,
	saturday int
)as

begin

	

	--start of my function



	declare @startdate date=@monthh;
	declare @enddate date=eomonth(@startdate);
	declare @currentdate date=@startdate;


	declare @dates table(
		dayy date
	);

	declare @startdow int = datepart(weekday,@startdate)

	if @startdow<>7
	begin
		declare @counter int = 1;
		while @counter<@startdow
		begin
			insert into @dates
			values (null)
			set @counter=@counter+1;
		end
	end

	while @currentdate<=@enddate
	begin
		insert into @dates
		values(@currentdate);
		set @currentdate=dateadd(day,1,@currentdate);
	end;




	declare @enddow int = datepart(weekday,@enddate)

	if @enddow<>6
	begin
		declare @counter1 int = @enddow;
		if @enddow=7
		begin
			set @counter1=0;
		end;
		while @counter1<7
		begin
			insert into @dates
			values (null)
			set @counter1=@counter1+1;
		end;
	end;

--	select datepart(weekday,dayy) from @dates;


	with numberdates as(
	
		select
			dayy,
			ROW_NUMBER() over (order by(select null)) as rn
		from @dates
	),
	groupdates as(
		select 
			((rn-1)/7) as weeknum,
			((rn-1)%7) as weekdayindex,
			dayy
		from numberdates
	)

	insert into @calendar(sunday, monday, tuesday, wednesday, thursday, friday, saturday)
	select
		MAX(CASE WHEN WeekDayIndex = 0 THEN day(dayy) END) AS Sunday,
		MAX(CASE WHEN WeekDayIndex = 1 THEN day(dayy) END) AS Monday,
		MAX(CASE WHEN WeekDayIndex = 2 THEN day(dayy) END) AS Tuesday,
		MAX(CASE WHEN WeekDayIndex = 3 THEN day(dayy) END) AS Wednesday,
		MAX(CASE WHEN WeekDayIndex = 4 THEN day(dayy) END) AS Thursday,
		MAX(CASE WHEN WeekDayIndex = 5 THEN day(dayy) END) AS Friday,
		MAX(CASE WHEN WeekDayIndex = 6 THEN day(dayy) END) AS Saturday
	from groupdates
	group by weeknum;

	return;
	--end of my function
end;
go

declare @monthh date ='2024-01-03'

SELECT * 
FROM dbo.calendar_maker(@monthh);


