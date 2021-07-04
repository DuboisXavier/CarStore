CREATE PROCEDURE [dbo].[CSP_AddAdresse]
	@numero nvarchar(30),
	@rue nvarchar(255),
	@ville nvarchar(255),
	@codePostal nvarchar(255),
	@Pays nvarchar(255)
	
AS
begin
	insert into Adresse(Numero, Rue, Ville, CodePostal, Pays) 
		values (@numero, @rue, @ville, @codePostal, @Pays);
	RETURN 0
end
