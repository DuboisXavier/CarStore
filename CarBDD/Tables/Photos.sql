CREATE TABLE [dbo].[Photos]
(
	[Id] INT PRIMARY KEY identity,
	Nom nvarchar(255) not null,
	MimeType nvarchar(255) NOT NULL,
	[Image] VARBINARY(MAX) NOT NULL,
	PieceId int
    CONSTRAINT [FK_Photos_Piece] FOREIGN KEY ([PieceId]) REFERENCES [Piece]([Id])
)
