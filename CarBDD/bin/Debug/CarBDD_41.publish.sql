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
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Création de la base de données $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                RECOVERY FULL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'Impossible de modifier les paramètres de base de données. Vous devez être administrateur système pour appliquer ces paramètres.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'Impossible de modifier les paramètres de base de données. Vous devez être administrateur système pour appliquer ces paramètres.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET TEMPORAL_HISTORY_RETENTION ON 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
PRINT N'Suppression de Autorisation Autorisation...';


GO
REVOKE VIEW ANY COLUMN ENCRYPTION KEY DEFINITION TO PUBLIC CASCADE;


GO
PRINT N'Suppression de Autorisation Autorisation...';


GO
REVOKE VIEW ANY COLUMN MASTER KEY DEFINITION TO PUBLIC CASCADE;


GO
PRINT N'Création de Table [dbo].[Adresse]...';


GO
CREATE TABLE [dbo].[Adresse] (
    [Id]         INT            IDENTITY (1, 1) NOT NULL,
    [Numero]     NVARCHAR (30)  NOT NULL,
    [Rue]        NVARCHAR (255) NULL,
    [Ville]      NVARCHAR (255) NULL,
    [CodePostal] NVARCHAR (255) NULL,
    [Pays]       NVARCHAR (255) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Création de Table [dbo].[Categorie_piece]...';


GO
CREATE TABLE [dbo].[Categorie_piece] (
    [Id]        INT            IDENTITY (1, 1) NOT NULL,
    [Categorie] NVARCHAR (255) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Création de Table [dbo].[Marque]...';


GO
CREATE TABLE [dbo].[Marque] (
    [Id]         INT           IDENTITY (1, 1) NOT NULL,
    [Nom_Marque] VARCHAR (255) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Création de Table [dbo].[Photos]...';


GO
CREATE TABLE [dbo].[Photos] (
    [Id]       INT             IDENTITY (1, 1) NOT NULL,
    [Nom]      NVARCHAR (255)  NOT NULL,
    [Image]    VARBINARY (MAX) NOT NULL,
    [MimeType] NVARCHAR (255)  NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Création de Table [dbo].[Piece]...';


GO
CREATE TABLE [dbo].[Piece] (
    [Id]             INT             IDENTITY (1, 1) NOT NULL,
    [Nom]            NVARCHAR (255)  NOT NULL,
    [Reference]      NVARCHAR (255)  NOT NULL,
    [Prix]           DECIMAL (20, 2) NOT NULL,
    [MarqueId]       INT             NULL,
    [CategoriePiece] INT             NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Création de Table [dbo].[Utilisateur]...';


GO
CREATE TABLE [dbo].[Utilisateur] (
    [Id]         INT            IDENTITY (1, 1) NOT NULL,
    [Nom]        NVARCHAR (255) NOT NULL,
    [Prenom]     NVARCHAR (255) NOT NULL,
    [Email]      NVARCHAR (255) NOT NULL,
    [MotDePasse] NVARCHAR (255) NOT NULL,
    [Role]       NVARCHAR (255) NOT NULL,
    [Telephone]  NVARCHAR (255) NOT NULL,
    [AdresseId]  INT            NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Création de Clé étrangère [dbo].[FK_PieceMarque]...';


GO
ALTER TABLE [dbo].[Piece]
    ADD CONSTRAINT [FK_PieceMarque] FOREIGN KEY ([MarqueId]) REFERENCES [dbo].[Marque] ([Id]) ON DELETE SET NULL;


GO
PRINT N'Création de Clé étrangère [dbo].[FK_PieceCategorie]...';


GO
ALTER TABLE [dbo].[Piece]
    ADD CONSTRAINT [FK_PieceCategorie] FOREIGN KEY ([CategoriePiece]) REFERENCES [dbo].[Categorie_piece] ([Id]) ON DELETE SET NULL;


GO
PRINT N'Création de Clé étrangère [dbo].[FK_Utilisateur_Adresse]...';


GO
ALTER TABLE [dbo].[Utilisateur]
    ADD CONSTRAINT [FK_Utilisateur_Adresse] FOREIGN KEY ([AdresseId]) REFERENCES [dbo].[Adresse] ([Id]) ON DELETE SET NULL;


GO
PRINT N'Création de Procédure [dbo].[CSP_AddAdresse]...';


GO
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
GO
PRINT N'Création de Procédure [dbo].[CSP_AddCategoriePiece]...';


GO
CREATE PROCEDURE [dbo].[CSP_AddCategoriePiece]
	@Categorie nvarchar(255)
	
	
AS
begin
	insert into Categorie_piece(Categorie) 
		values (@Categorie);
	RETURN 0
end
GO
PRINT N'Création de Procédure [dbo].[CSP_AddMarque]...';


GO
CREATE PROCEDURE [dbo].[CSP_AddMarque]
	@Nom_Marque nvarchar(255)
	
	
AS
begin
	insert into Marque (Nom_Marque) 
		values (@Nom_Marque);
	RETURN 0
end
GO
PRINT N'Création de Procédure [dbo].[CSP_AddPiece]...';


GO
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
GO
PRINT N'Création de Procédure [dbo].[CSP_AddUtilisateur]...';


GO
CREATE PROCEDURE [dbo].[CSP_AddUtilisateur]
	@nom nvarchar(30),
	@prenom nvarchar(255),
	@email nvarchar(255),
	@telephone nvarchar(255),
	@motDePasse nvarchar(255),
	@role nvarchar(255)
	
AS
begin
	insert into Utilisateur(Nom, Prenom, Email, Telephone, MotDePasse, [Role]) 
		values (@nom, @prenom, @email, @telephone, @motDePasse, @role);
	RETURN 0
end
GO
PRINT N'Création de Procédure [dbo].[CSP_UpdateAdresse]...';


GO
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
GO
PRINT N'Création de Procédure [dbo].[CSP_UpdateCategoriePiece]...';


GO
CREATE PROCEDURE [dbo].[CSP_UpdateCategoriePiece]
	@id int,
	@Categorie nvarchar(255)
		
AS
begin
	update Categorie_piece set Categorie = @Categorie				
					where Id = @Id
	RETURN 0
end
GO
PRINT N'Création de Procédure [dbo].[CSP_UpdateMarque]...';


GO
CREATE PROCEDURE [dbo].[CSP_UpdateMarque]
	@id int,
	@Nom_Marque nvarchar(255)
		
AS
begin
	update Marque set Nom_Marque = @Nom_Marque					
					where Id = @Id
	RETURN 0
end
GO
PRINT N'Création de Procédure [dbo].[CSP_UpdatePiece]...';


GO
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
GO
PRINT N'Création de Procédure [dbo].[CSP_UpdateUtilisateur]...';


GO
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
insert into Categorie_piece values ('Freins');
insert into Piece values ('Bougie de préchauffage', 'EFA-055', 55.10, 1, 1);
/*attention a l'ordre des insert !!!*/
insert into Adresse values ('10', 'Rue de la Croyere', 'Manage', '7170', 'belgique')
insert into Utilisateur values ('Dubois', 'Xavier', 'hilyst@gmail.com', 'azerty', 'Admin', '0499/24.61.14', 1)
insert into Photos values ('disque', convert(varbinary, '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gvj5sjmn67mt4fP1ESNRZI90CQGyWCP1ErimG3/Uqzt1mXOZlWMdYNM+pgxg+YM0Frq8RFcHMMN+3XBf5gkzwBRKme024zzAQBMImGG/Mq5dQdnwk03hke0zl4fcw0iFLVoX6XEpTF+Tpbr5g5AgRjyRxxrrBzrzGjGusbOsELXRBnq+saurL6wkpGgC1lsWc7Fdjc3ihVgexDBWA4/x9nmfQ/yA3ZLgSYQWTNSiyPkJQIIH8BaVC4uNJV8xD7wenEcjtFUMFI9P8Ismg7O3zD2QLvQ+CV+Gi+2DwDl/ZKePUCn/ALpmyPEzZA/DLw+LdO0Sswufs+YBuMjJAjgnh0VX7ghvNDTM1fxPqAUQVwPcSazQ236mnGYQ9xN/6MGV2/ydnmfQ/wA6v/ED/wCSpVMPzpczKlVOP+Bvj/K2eZ9D/wDkdnmCALMdpnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqeotV/T/8AOP8A/8QAJREAAgICAwADAQACAwAAAAAAAAECERAgITAxEkBBUTJwA1Bh/9oACAECAQE/AP8AbN0fI+R8mWy2KQpJ5tHyPkWy2WxSoUk/rynzSKxel4U69HKxLa8Rl9RtIc20JXhj0rFJsSwx6VmMv79JuhtyFlj0vCWLw90Ql/foydujwSosQx5eKoXGjy9fBO13yddNjytbLOdoPmu9u3u3fB4WIeby3fB4WXitU7XbJ0hca2f5OhtLhYSrayvkOS8WKrNnukH+ds+XQ+Fr+kpVwi7Ix4tn6MWi5JS/FiMa9Hi9o+9vrJYsvDdISEi+Bf0eLLxJ0uBKhe3hlboXnW/CI9LHzlqjxD0vKHwerD3j51yYuEPWy8N2fg9bLESViFGxwGqe0Hx1yPNmLL42YsWR5y1e0OuXpLZiwvSWtDQsxVLSXvGsOuXpLVaIls8r0Xmkv8tYdb9JC1YvSSoRIWrF6NUxei0l7rDrl6S1sbx+C9Ja2N58Iu1o+XrDrl6S2YsIlsxZg+KzJ0toedc/R+bMWF6S2Ysp0KaPmhux6x86/wDk8s/N/wBxXFj5XTXFixQsVlC8658oXKH0XwLldLfFbvEfexng+lfwfvZeXiC7Z8Mfm1FVhD56qK0ooSpdslaFyearLPVtetl6RV97XxY+d7LI8D3ssvVciVLvlGyL/BrpXPYsRX0ZRFzwxquhC54Gq64q/puJ7wVXQmPngqulKxKvqOJ/4xx3jFs+P8GrGq3jG/RKvPrNWfEcBxZ8WKLZ8GKCy1Y42OB8WfFnxYoMUEv+nr/bn//EACgRAAICAQMEAgMBAAMAAAAAAAABAhEhECAxAxIwQTJRIkBhcRNwgP/aAAgBAwEBPwD/ALZSbO07UdqFFHahw+hxa1SbO07UdqFFHahw+hprn9eELyxtetFotbHD6Iw9sbXrRaLXnklH9RJy4P8AjUc+yUvWq0WqycOiT9LVaLbOP1+klbI/gsDdC+9VtuiUqVbFv5Jqv0YxpWWc7Vq8FjznyVaGqfngrHnCOcbUxKzCLTHncmLS0Y29RWvOl2oWM7GVbElHku+ChultZViSXJ/mjWif3sY1T8sFbJZdDW3EVYk5ZZwhOx5eN19gk3lnB3leyjtIv09nUXvy9NUrI5dj1obojFvLEvRKXpCxEh97KG6IxbyyqJSsW1azVryezhURVIexK3kbJPFCG6VEcLao27Y2mSeNFsQ1qx8+OCuSJZe5/RWB5IPND5PW3+FYGQdoeHsrbNU/H0+T3rRRwRJaRVWzl60UcESXGkF2oY51g7yL7t3U5vx9NfjZH8trZEl9HB6I7WyOOSWs3WsX2svb1PXjh8CG18iHzo8RI7fej1k7eyOUtvU9eOPwIC2PDE8ay4IcC2cMT2PnZD4rb1PExfAhxtfIh8Mg21knwQ4Fq+NESwmQbayPjbH4oednV9eJkfgQFo9GsiWlWS4I8C2UJaNZP4SVPYsJLb1PHD4EBbHsksEOBbHt6kc3rFW9FqzqPPj6T/FkMPb6EPjR8EHnaxDFo1aocH6FBiXaI4FrJ2/H0sOjh7Uzg50Tt0Lnbye9OBSd0c6PYtG6R78cHTJYd6XpenIhqhLNjwxsvSxD0aKzYtHtsm8eS6HmNi40vXjS7PZJez1pel6PBzotL3Tea8vTdxoX1tRdcn+DGrRH63J1yL+HJwXpdvGy8DdvywdMeMnrav6f5omfFj2r+n+a2UJJIes3jzxfdEWd9WVQ1Ys72itL2WN354S7WPGUf3wL6GqflZJ+v0YSvDOPAhnHklLt4/TjK8M48XG1D0Yhyoef1FP7ExPfKaQp/Yi9UPWU64G7/W4O5imKaFJDkkd6HNvVOjuYpnehSQ5IfUSHNv8A8B//2Q=='), 'image/jpeg')


GO

GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Mise à jour terminée.';


GO
