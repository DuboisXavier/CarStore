CREATE PROCEDURE [dbo].[CSP_AddPiece]
	@Nom nvarchar(255),
	@Reference nvarchar(255),
	@Prix decimal(20,2),
	@MarqueId int
	
	
AS
begin
	insert into Piece (Nom, Reference, Prix, MarqueId) 
		values (@Nom, @Reference, @Prix, @MarqueId);
	RETURN 0
end
