CREATE PROCEDURE [dbo].[CSP_UpdateUtilisateur]
	@Id int,
	@Nom nvarchar(255),
	@Prenom nvarchar(255),
	@Email nvarchar(255),
	@Telephone nvarchar(255),
	@MotDePasse nvarchar(255),
	@Role nvarchar(255)
	
AS
begin
	update Utilisateur set Nom = @Nom, 
					Prenom = @Prenom, 
					Email = @Email, 
					Telephone = @Telephone,
					MotDePasse = @MotDePasse,
					[Role] = @Role
					where Id = @Id
		
	RETURN 0
end