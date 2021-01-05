use Afish
go

create trigger CheckClientTrigger1
on Clients
for insert
as
begin
 	declare @name nvarchar(50), @email nvarchar(50), @birthday date
	select @name = FullName, @email = Email, @birthday = Birthday from inserted
	if exists (select * from Clients where @name = FullName and @email = Email and @birthday = Birthday)
	begin
		print('Client already registered')
		rollback transaction
	end
End
go

create trigger CheckEventTrigger
on Events
for insert 
as
begin
	declare @name nvarchar(20), @start_date smalldatetime, @end_date smalldatetime, @place nvarchar(10)
	select @name = Name, @start_date = StartDate, @end_date = EndDate, @place = Place from inserted
	if exists (select * from Events where @name = Name and @start_date = StartDate and @end_date = EndDate and @place = Place)
	begin
		print('Event already registered')
		rollback transaction
	end
End
go

/*
При удалении прошедших событий необходимо их переносить в архив событий
*/
create trigger CheckEventDeleteTrigger
on Events 
for delete 
as 
begin
	insert into ArchiveEvents select Name, StartDate, EndDate, Country, 
	City, Place, CategoryId, Description, AgeLimit, MaxNumTickets, PurchasedNumTickets
	from deleted
	print('Data is archived')
End
go

create trigger CheckMaxNumTickets
on Tickets
for insert 
as 
begin
	declare @event_id int
	select @event_id = EventId from inserted
	if ((select MaxNumTickets from Events where id = @event_id) = (select PurchasedNumTickets from Events where id = @event_id))
	begin
		print('Maximum number of tickets reached')
		rollback transaction
	end
End
go

create trigger CheckAgeLimit
on Tickets
for insert 
as
begin
	declare @client_id int, @event_id int, @birthday date
	select @client_id = ClientId, @event_id = EventId from inserted
	select @birthday = Birthday from Clients where Id = @client_id
	if (DATEDIFF(day, @birthday, GETDATE()) / 365.25 < (select AgeLimit from Events where Id = @event_id))
	begin
		print('Age limit error')
		rollback transaction
	end
End