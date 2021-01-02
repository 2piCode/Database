create database Afish
go

use Afish
go

CREATE TABLE CategoryEvents
(
	[Id] int not null identity(1,1) primary key,
	[Name] nvarchar(20) check(Name <> N'') not null
)

CREATE TABLE Events
(
	[Id] int not null identity(1,1) primary key,
	[Name] nvarchar(20) check(Name <> N'') not null,
	[StartDate] smalldatetime not null,
	[EndDate] smalldatetime,
	[Country] nvarchar(10) check(Country <> N'') not null,
	[City] nvarchar(10) check(City <> N'') not null,
	[Place] nvarchar(10) check(Place <> N'') not null,
	[CategoryId] int not null, 
	[Description] nvarchar(100),
	[AgeLimit] int not null,
	[Image] image,
	[MaxNumTickets] int not null,
	[PurchasedNumTickets] int not null,
	FOREIGN KEY (CategoryId) REFERENCES CategoryEvents(Id)
)

CREATE TABLE Clients
(
	[Id] int not null identity(1,1) primary key,
	[FullName] nvarchar(50) check(FullName <> N'') not null,
	[Email] nvarchar(50) check(Email <> N'') not null,
	[Birthday] date not null
)

CREATE TABLE Tickets
(
	[Id] int not null identity(1,1) primary key,
	[Price] money not null,
	[EventId] int not null,
	[ClientId] int not null,
	FOREIGN KEY (EventId) REFERENCES Events(Id),
	FOREIGN KEY (ClientId) REFERENCES Clients(Id)
)

CREATE TABLE ArchiveEvents
(
	[Id] int not null identity(1,1) primary key,
	[Name] nvarchar(10) check(Name <> N'') not null,
	[StartDate] smalldatetime not null,
	[EndDate] smalldatetime,
	[Country] nvarchar(10) check(Country <> N'') not null,
	[City] nvarchar(10) check(City <> N'') not null,
	[Place] nvarchar(10) check(Place <> N'') not null,
	[CategoryId] int not null, 
	[Description] nvarchar(50),
	[AgeLimit] int not null,
	[Image] image,
	[MaxNumTickets] int not null,
	[PurchasedTickects] int not null,
	FOREIGN KEY (CategoryId) REFERENCES CategoryEvents(Id)
)