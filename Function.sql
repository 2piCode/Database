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
where MaxNumTickets = PurchasedTickets
)

create function Top3PopularEvents()
returns table
as
return(
select TOP 3 Name 
from Events 
ORDER BY PurchasedTickets DESC
)



create function MostPopularEvents(@city nvarchar(10))
returns table
as
return(
select TOP 1 Name 
from Events 
where City = @city
ORDER BY PurchasedTickets DESC
)