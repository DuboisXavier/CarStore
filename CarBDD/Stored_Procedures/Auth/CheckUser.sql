CREATE PROCEDURE [dbo].[CheckUser]
	@Email nvarchar(255),
	@MotDePasse varchar(255)
AS
Begin
	SELECT * 
	from [Utilisateur] 
	where Email = @Email and MotDePasse = HASHBYTES('SHA2_512', dbo.GetPreSalt() + @MotDePasse + dbo.GetPostSalt());
End