CREATE PROCEDURE [dbo].[CSP_UpdateCommand]
	@Numero int,
	@status nvarchar(255),
	@date nvarchar(255),
	@UtilisateurId int
	
	
AS
begin
	update Commande set  
					[Status] = @status, 
					[Date] = @date, 
					UtilisateurId = @UtilisateurId
					where Numero = @Numero
		
	RETURN 0
end
