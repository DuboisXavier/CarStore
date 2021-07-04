CREATE TABLE [dbo].[Utilisateur]
(
	[Id] INT PRIMARY KEY identity,
	Nom nvarchar(255) NOT NULL,
	Prenom nvarchar(255) NOT NULL,
	Email nvarchar(255) NOT NULL,
	MotDePasse nvarchar(255) NOT NULL,
	[Role] nvarchar(255) NOT NULL,
	Telephone nvarchar(255) NOT NULL,
	AdresseId int, 
    CONSTRAINT [FK_Utilisateur_Adresse] FOREIGN KEY ([AdresseId]) REFERENCES [Adresse]([Id]) on delete set null
)
