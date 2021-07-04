CREATE PROCEDURE [dbo].[CSP_UpdatePiece]
	@Id int,
	@Nom nvarchar(255),
	@Reference nvarchar(255),
	@Prix decimal(20,2),
	@MarqueId int
	
	
AS
begin
	update Piece set Nom = @Nom, 
					Reference = @Reference, 
					Prix = @Prix, 
					MarqueId = @MarqueId
					where Id = @Id
		
	RETURN 0
end
