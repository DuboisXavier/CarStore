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
