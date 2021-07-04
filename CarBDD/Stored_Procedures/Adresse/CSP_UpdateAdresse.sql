CREATE PROCEDURE [dbo].[CSP_UpdateAdresse]
	@Id int,
	@numero nvarchar(30),
	@rue nvarchar(255),
	@ville nvarchar(255),
	@codePostal nvarchar(255),
	@Pays nvarchar(255)
	
AS
begin
	update Adresse set Numero = @numero,
						Rue = @rue, 
						Ville = @ville, 
						CodePostal = @codePostal,
						Pays = @Pays

					where Id = @Id
	RETURN 0
end