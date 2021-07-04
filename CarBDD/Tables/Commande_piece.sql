CREATE TABLE [dbo].[Commande_piece]
(
	[Id] INT PRIMARY KEY identity,
	Quantite int NOT NULL,
	Prix int NOT NULL, 
	CommandeId int,
	PieceId int
    CONSTRAINT [FK_Commande_piece_ToCommande] FOREIGN KEY ([CommandeId]) REFERENCES [Commande]([Numero]), 
    CONSTRAINT [FK_Commande_piece_ToPiece] FOREIGN KEY ([PieceId]) REFERENCES [Piece]([Id])


)

