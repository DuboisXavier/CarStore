CREATE PROCEDURE [dbo].[CSP_AddMarque]
	@Nom_Marque nvarchar(255)
	
	
AS
begin
	insert into Marque (Nom_Marque) 
		values (@Nom_Marque);
	RETURN 0
end
