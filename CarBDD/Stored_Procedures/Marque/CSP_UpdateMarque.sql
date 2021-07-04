CREATE PROCEDURE [dbo].[CSP_UpdateMarque]
	@id int,
	@Nom_Marque nvarchar(255)
		
AS
begin
	update Marque set Nom_Marque = @Nom_Marque					
					where Id = @Id
	RETURN 0
end
