CREATE PROCEDURE [dbo].[CSP_AddCategoriePiece]
	@Categorie nvarchar(255)
	
	
AS
begin
	insert into Categorie_piece(Categorie) 
		values (@Categorie);
	RETURN 0
end
