CREATE TABLE [dbo].[Adresse]
(
	[Id] INT PRIMARY KEY identity,
	Numero nvarchar(30) not null,
	Rue nvarchar(255),
	Ville nvarchar(255),
	CodePostal nvarchar(255),
	Pays nvarchar(255)
)
