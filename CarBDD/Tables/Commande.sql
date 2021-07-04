CREATE TABLE [dbo].[Commande]
(
	Numero INT PRIMARY KEY identity,
	[Status] nvarchar(255) NOT NULL,
	[Date] nvarchar(255) NOT NULL,
	UtilisateurId int, 
    CONSTRAINT [FK_Commande_T] FOREIGN KEY ([UtilisateurId]) REFERENCES [Utilisateur]([Id])

)
