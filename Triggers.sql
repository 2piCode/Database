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
