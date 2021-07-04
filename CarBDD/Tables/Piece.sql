CREATE TABLE [dbo].[Piece]
(
	[Id] INT PRIMARY KEY identity,
	Nom nvarchar(255) not null,
	Reference nvarchar(255) not null,
	Prix decimal(20,2) not null,
	MarqueId int,
	CategorieId int,
    CONSTRAINT [FK_PieceMarque] FOREIGN KEY ([MarqueId]) REFERENCES Marque(Id) on delete set null,
	CONSTRAINT [FK_PieceCategorie] FOREIGN KEY ([CategorieId]) REFERENCES Categorie_piece(Id) on delete set null
    

)
