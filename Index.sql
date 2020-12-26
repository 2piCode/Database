use Afish
go

create index i_client on Clients(FullName)

create nonclustered index i_email on Clients(Email)

create index i_events on Events(Name)

create nonclustered index i_date on Events(StartDate)
include(EndDate)

create index i_archive_events on ArchiveEvents(Name)

create nonclustered index i_archive_date on ArchiveEvents(StartDate)
include(EndDate)

create nonclustered index i_ticket_price on Tickets(Price)
include(EventName)
