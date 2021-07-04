CREATE PROCEDURE [dbo].[CSP_UpdateCategoriePiece]
	@id int,
	@Categorie nvarchar(255)
		
AS
begin
	update Categorie_piece set Categorie = @Categorie				
					where Id = @Id
	RETURN 0
end

