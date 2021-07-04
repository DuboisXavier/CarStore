CREATE PROCEDURE [dbo].[CSP_AddCommand]
	
	@status nvarchar(255),
	@date nvarchar(255),
	@UtilisateurId int

	
	
AS
begin
	insert into Commande([status], [date], UtilisateurId) 
		values ( @status, @date, @UtilisateurId);
	RETURN 0
end
