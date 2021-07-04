/*
Script de déploiement pour CarBDD

Ce code a été généré par un outil.
La modification de ce fichier peut provoquer un comportement incorrect et sera perdue si
le code est régénéré.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "CarBDD"
:setvar DefaultFilePrefix "CarBDD"
:setvar DefaultDataPath "D:\Program Files\MSSQL15.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "D:\Program Files\MSSQL15.MSSQLSERVER\MSSQL\DATA\"

GO
:on error exit
GO
/*
Détectez le mode SQLCMD et désactivez l'exécution du script si le mode SQLCMD n'est pas pris en charge.
Pour réactiver le script une fois le mode SQLCMD activé, exécutez ce qui suit :
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'Le mode SQLCMD doit être activé de manière à pouvoir exécuter ce script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'Création de Procédure [dbo].[CSP_AddCommand]...';


GO
CREATE PROCEDURE [dbo].[CSP_AddCommand]
	@Numero int,
	@status nvarchar(255),
	@date nvarchar(255),
	@UtilisateurId int

	
	
AS
begin
	insert into Commande(Numero, [status], [date], UtilisateurId) 
		values (@Numero, @status, @date, @UtilisateurId);
	RETURN 0
end
GO
/*
Modèle de script de post-déploiement							
--------------------------------------------------------------------------------------
 Ce fichier contient des instructions SQL qui seront ajoutées au script de compilation.		
 Utilisez la syntaxe SQLCMD pour inclure un fichier dans le script de post-déploiement.			
 Exemple :      :r .\monfichier.sql								
 Utilisez la syntaxe SQLCMD pour référencer une variable dans le script de post-déploiement.		
 Exemple :      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
insert into Marque values ('GKN');
insert into Categorie_piece values ('Moteur');/*id1*/
insert into Categorie_piece values ('Frein');/*id2*/
insert into Categorie_piece values ('Demarrage electrique');/*id3*/
insert into Categorie_piece values ('Carrosserie');/*id4*/
insert into Piece values ('Bougie de préchauffage', 'EFA-055', 55.10, 1, 1);
insert into Piece values ('Bougie d''allumage', 'EGH-074', 48.10, 1, 1);
insert into Piece values ('Disque de freins', 'HYUIO-07', 80.10, 1, 2);
insert into Piece values ('Plaquette de frein', 'YH-48596', 25.90, 1, 2);
insert into Piece values ('Retroviseur', 'YT-88546', 120, 1, 4);
insert into Piece values ('Batterie', 'RTEXD-115', 55.10, 1, 3);
insert into Piece values ('Alternateur', 'U-155-Z', 55.10, 1, 3);

insert into Adresse values ('10', 'Rue de la Croyere', 'Manage', '7170', 'belgique');




GO

GO
PRINT N'Mise à jour terminée.';


GO
