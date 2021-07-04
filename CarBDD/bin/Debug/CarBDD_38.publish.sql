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
    [Nom]      VARCHAR (1)     NOT NULL,
    [Image]    VARBINARY (MAX) NOT NULL,
    [MimeType] VARCHAR (1)     NOT NULL,
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
insert into Photo values ('disque', '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
G1dbRWhSSzb917O4mFYNt9f6BSaU5/ciDPlQxmDfSSSdUIWmuoETZ3PlkCQc6eDoa3FdXUu76g9R
UiI4iJw/PA1RHPhomRkaMkkknRCVkbNzvLEFML8/bPIsL7aDNKWVkcr9acGHWKx90hZ5RGPgQG9y
tHo0QRoiFnTdBEK3p7CFhJJcLWByUO0cmdRhkmZc0T/Q7nydtfxhwl4iqEo3puGytGRJBBGjGhKW
QD9sjpKh3ER9u8iwvuGOCGpXUbX/AJRkekiW2IaT7PIxRd4IJLqTMx4bJyPPQxwwrOrdI4h90YlH
oqiXEkjZp6lETFKSqZhsMcspzsFr18yMim43kdQ/ApICtPehm3dZMnpwQNpS5Lf3TyLC/wDIvIsL
/wAi8kf+R7v/AJx//8QAKxABAAICAQQCAgICAwEBAQAAAQARITFBUWFxkYGhMLHB0UDhECDw8ZBg
/9oACAEBAAE/EP8A8kAvX1Kd/TKd/TKd/TKd/TKd/TKd/TKd/TKd/TKd/TKd/TKd/TKd/TKd/TKd
/TKd/TKd/TKd/TKd/TKd/TKd/TKd/TKd/TKd/TKd/TKd/TK9/TKd/TKd/TKd/TK9/TKd/TKd/TKd
/TKd/TK9/TK9/TKd/TKd/TKd/TKd/TKd/TKd/TKd/TKd/TKd/TK9/TKd/TKd/TKd/TK9/TKd/TKd
/TKd/TKd/TK9/TK9/TKd/TKd/TKd/TKd/TKd/TKd/TKd/TKd/TKd/TKd/TKd/TKd/TKd/TKd/TKd
/TKd/TKd/TKd/TKd/TKd/TKd/TKd/TKd/TKd/TEmrmnh/lMuXLly5cuXLuXL/Cy5cuXLly5cv/i/
8hZeZ9D/ACmPzTaf0ilFxS27vAd4g7lXy6NIp8pQfgh1ozi2/cMlKVvBCuF9EsXY9kII2XFWSiLN
11Bvdh+F/wDMMVWrC2+JULbDKr30p5kfsdxiXLuLv8TCQHG33EsX4xLjSnwSy6ccIpLzlwlaReMv
uBkjlf5GzzPof5CgALVaDzBA76oD58x/CteYN0ubGqqW703EOgnHlYeaK8FrMs7p9Qt8u2Na25Ub
lI07j3URHThqc3PDLNrs1Ecm1XA/uBL7tND4/wClXDMRYAfLABibm+kWb+JajaRWtgpbusCCQL3G
bB36+ZScJH44NxwUNVH1uOzI2yp3FuIvcZbMqbMMGohuhVKS4PDSeSJTxw5PiUSnr/ibPM+h/jOL
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
qqY7N1jUS/8AUFRm3pBc9eZWCnHMNLWZqGDc7Y7a2ikEoDa9oMYDzIY/w9nmfQ/wXMrFR2AhSJhi
RpBVf7JR5EBCNjjIcCGSAHhNfyHMNJRVVHCRr5zzMu3FQB5ltMbpz5i6Ms0NfcyMb6yjZbcCbHPM
CmXMqc4it8ypd4ipCdtiKyv/AHMNST/LnjpH8rKw/SrpvDBIgttGcvr1hwHN5Xc6y4VBsuCzpCXR
xuOjKLsxF1JWMOe8bDioDRrOruAsGoDpZRhxM3fcE2itITU9XTyykBTlP1K/xNnmfQ/xHuhpSYa/
zydpeMzJrtb9kscWZB8Ou6of19Mdh8/MIKpttPJM2nc9ZWWdxEy1Fw8xR2iq4gnioOcwLNQUlY7S
xur4nVCZ0H9zIl94QpUAlqEofCErx1TOVYZXbUcnmZqOrodxupUpAi/A8vMwyyF2VGzEFtcxphjY
1OjmKOk4YzBPQgrrcq+PuCtSoFWuomVeaMHYhaT21ldX/G2eZ9D/ABalbf1AmAhFO5JlCj4bgvj5
sjmn67mt4fP1ESNRZI90CQGyWCP1ErimG3/Uqzt1mXOZlWMdYNM+pgxg+YM0Frq8RFcHMMN+3XBf
5gkzwBRKme024zzAQBMImGG/Mq5dQdnwk03hke0zl4fcw0iFLVoX6XEpTF+Tpbr5g5AgRjyRxxrr
BzrzGjGusbOsELXRBnq+saurL6wkpGgC1lsWc7Fdjc3ihVgexDBWA4/x9nmfQ/yA3ZLgSYQWTNSi
yPkJQIIH8BaVC4uNJV8xD7wenEcjtFUMFI9P8Ismg7O3zD2QLvQ+CV+Gi+2DwDl/ZKePUCn/ALpm
yPEzZA/DLw+LdO0Sswufs+YBuMjJAjgnh0VX7ghvNDTM1fxPqAUQVwPcSazQ236mnGYQ9xN/6MGV
2/ydnmfQ/wA6v/ED/wCSpVMPzpczKlVOP+Bvj/K2eZ9D/wDkdnmCALMdpnqepnqepnqepnqepnqe
pnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqe
pnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqe
pnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqe
pnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqepnqeotV/
T/8AOP8A/8QAJREAAgICAwADAQACAwAAAAAAAAECERAgITAxEkBBUTJwA1Bh/9oACAECAQE/AP8A
bN0fI+R8mWy2KQpJ5tHyPkWy2WxSoUk/rynzSKxel4U69HKxLa8Rl9RtIc20JXhj0rFJsSwx6VmM
v79JuhtyFlj0vCWLw90Ql/foydujwSosQx5eKoXGjy9fBO13yddNjytbLOdoPmu9u3u3fB4WIeby
3fB4WXitU7XbJ0hca2f5OhtLhYSrayvkOS8WKrNnukH+ds+XQ+Fr+kpVwi7Ix4tn6MWi5JS/FiMa
9Hi9o+9vrJYsvDdISEi+Bf0eLLxJ0uBKhe3hlboXnW/CI9LHzlqjxD0vKHwerD3j51yYuEPWy8N2
fg9bLESViFGxwGqe0Hx1yPNmLL42YsWR5y1e0OuXpLZiwvSWtDQsxVLSXvGsOuXpLVaIls8r0Xmk
v8tYdb9JC1YvSSoRIWrF6NUxei0l7rDrl6S1sbx+C9Ja2N58Iu1o+XrDrl6S2YsIlsxZg+KzJ0to
edc/R+bMWF6S2Ysp0KaPmhux6x86/wDk8s/N/wBxXFj5XTXFixQsVlC8658oXKH0XwLldLfFbvEf
exng+lfwfvZeXiC7Z8Mfm1FVhD56qK0ooSpdslaFyearLPVtetl6RV97XxY+d7LI8D3ssvVciVLv
lGyL/BrpXPYsRX0ZRFzwxquhC54Gq64q/puJ7wVXQmPngqulKxKvqOJ/4xx3jFs+P8GrGq3jG/RK
vPrNWfEcBxZ8WKLZ8GKCy1Y42OB8WfFnxYoMUEv+nr/bn//EACgRAAICAQMEAgMBAAMAAAAAAAAB
AhEhECAxAxIwQTJRIkBhcRNwgP/aAAgBAwEBPwD/ALZSbO07UdqFFHahw+hxa1SbO07UdqFFHahw
+hprn9eELyxtetFotbHD6Iw9sbXrRaLXnklH9RJy4P8AjUc+yUvWq0WqycOiT9LVaLbOP1+klbI/
gsDdC+9VtuiUqVbFv5Jqv0YxpWWc7Vq8FjznyVaGqfngrHnCOcbUxKzCLTHncmLS0Y29RWvOl2oW
M7GVbElHku+ChultZViSXJ/mjWif3sY1T8sFbJZdDW3EVYk5ZZwhOx5eN19gk3lnB3leyjtIv09n
UXvy9NUrI5dj1obojFvLEvRKXpCxEh97KG6IxbyyqJSsW1azVryezhURVIexK3kbJPFCG6VEcLao
27Y2mSeNFsQ1qx8+OCuSJZe5/RWB5IPND5PW3+FYGQdoeHsrbNU/H0+T3rRRwRJaRVWzl60UcESX
GkF2oY51g7yL7t3U5vx9NfjZH8trZEl9HB6I7WyOOSWs3WsX2svb1PXjh8CG18iHzo8RI7fej1k7
eyOUtvU9eOPwIC2PDE8ay4IcC2cMT2PnZD4rb1PExfAhxtfIh8Mg21knwQ4Fq+NESwmQbayPjbH4
oednV9eJkfgQFo9GsiWlWS4I8C2UJaNZP4SVPYsJLb1PHD4EBbHsksEOBbHt6kc3rFW9FqzqPPj6
T/FkMPb6EPjR8EHnaxDFo1aocH6FBiXaI4FrJ2/H0sOjh7Uzg50Tt0Lnbye9OBSd0c6PYtG6R78c
HTJYd6XpenIhqhLNjwxsvSxD0aKzYtHtsm8eS6HmNi40vXjS7PZJez1pel6PBzotL3Tea8vTdxoX
1tRdcn+DGrRH63J1yL+HJwXpdvGy8DdvywdMeMnrav6f5omfFj2r+n+a2UJJIes3jzxfdEWd9WVQ
1Ys72itL2WN354S7WPGUf3wL6GqflZJ+v0YSvDOPAhnHklLt4/TjK8M48XG1D0Yhyoef1FP7ExPf
KaQp/Yi9UPWU64G7/W4O5imKaFJDkkd6HNvVOjuYpnehSQ5IfUSHNv8A8B//2Q==', 'image/jpeg')


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
