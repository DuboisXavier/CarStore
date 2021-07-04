CREATE PROCEDURE [dbo].[CSP_AddUtilisateur]
	@Nom nvarchar(50),
	@Prenom nvarchar(50),
	@Email nvarchar(320),
	@Telephone varchar(20),
	@MotDePasse varchar(255),
	@Role varchar(20),
	@AdresseId int
AS
Begin
	Insert into [Utilisateur] ([Nom], [Prenom], [Email], [Telephone], [MotDePasse], [Role], [AdresseId])
	Values (@Nom, @Prenom, @Email, @Telephone, HASHBYTES('SHA2_512', dbo.GetPreSalt() + @MotDePasse + dbo.GetPostSalt()), @Role, @AdresseId);
End
