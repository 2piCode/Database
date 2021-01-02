use Afish
go

create function DateEvent(@date date)
returns table
as
return(
select Name
from Events
where @date between StartDate and EndDate
)
go

create function CategoryEvent(@category nvarchar(10))
returns table
as
return(
select Events.Name
from Events
join CategoryEvents on Events.CategoryId = CategoryEvents.Id
where CategoryEvents.Name = @category
)
go

create function SoldOut()
returns table
as
return(
select Name
from Events
where MaxNumTickets = PurchasedNumTickets
)
go

create function Top3PopularEvents()
returns table
as
return(
select TOP 3 Name 
from Events 
ORDER BY PurchasedNumTickets DESC
)
go

create function Top3PopularCategory()
returns table
as
return (
select Top 3 T.Name 
from (
	select CategoryEvents.Name, Events.PurchasedNumTickets +  ArchiveEvents.PurchasedTickects as [Num Tickets]
	from CategoryEvents
	join Events on Events.CategoryId = CategoryEvents.Id
	join ArchiveEvents on  ArchiveEvents.CategoryId = CategoryEvents.Id
) as T
ORDER BY T.[Num Tickets] DESC
)
go

create function MostPopularEvents(@city nvarchar(10))
returns table
as
return(
select TOP 1 Name 
from Events 
where City = @city
ORDER BY PurchasedNumTickets DESC
)
go

create function MostActiveClient()
returns table
as
return(
SELECT TOP 1 FullName
FROM (
	SELECT Clients.FullName, count(Tickets.Id) as [Num tickets]
	FROM Tickets
	join Clients on Tickets.ClientId = Clients.Id
	GROUP BY Clients.FullName
) as T
ORDER BY [Num tickets] DESC 
)
go


create function MostUnpopularCategory()
returns table
as
return (
select Top 1 T.Name 
from (
	select CategoryEvents.Name, count(Events.Id) + count(ArchiveEvents.Id) as [Num Events]
	from CategoryEvents
	join Events on Events.CategoryId = CategoryEvents.Id
	join ArchiveEvents on ArchiveEvents.CategoryId = CategoryEvents.Id
	GROUP BY CategoryEvents.Name
) as T
ORDER BY T.[Num Events] ASC
)
go

create function TodayInTime(@time time)
returns table
as
return(
select Name
from Events
where @time = cast(StartDate as time)
)
go

create function EventsTodayCity()
returns table
as
return(
select City
from Events
where GETDATE() between StartDate and EndDate
)
go