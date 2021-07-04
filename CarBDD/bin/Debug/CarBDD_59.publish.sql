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
    [MimeType] NVARCHAR (255)  NOT NULL,
    [Image]    VARBINARY (MAX) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Création de Table [dbo].[Piece]...';


GO
CREATE TABLE [dbo].[Piece] (
    [Id]          INT             IDENTITY (1, 1) NOT NULL,
    [Nom]         NVARCHAR (255)  NOT NULL,
    [Reference]   NVARCHAR (255)  NOT NULL,
    [Prix]        DECIMAL (20, 2) NOT NULL,
    [MarqueId]    INT             NULL,
    [CategorieId] INT             NULL,
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
    ADD CONSTRAINT [FK_PieceCategorie] FOREIGN KEY ([CategorieId]) REFERENCES [dbo].[Categorie_piece] ([Id]) ON DELETE SET NULL;


GO
PRINT N'Création de Clé étrangère [dbo].[FK_Utilisateur_Adresse]...';


GO
ALTER TABLE [dbo].[Utilisateur]
    ADD CONSTRAINT [FK_Utilisateur_Adresse] FOREIGN KEY ([AdresseId]) REFERENCES [dbo].[Adresse] ([Id]) ON DELETE SET NULL;


GO
PRINT N'Création de Fonction [dbo].[GetPostSalt]...';


GO
CREATE FUNCTION [dbo].[GetPostSalt]
(
)
RETURNS NCHAR(2048)
AS
BEGIN
	RETURN N'%QAV8&w*ep6SC=9LXY$qc!rREjk?Q8m!?hWbfW#*VF!Yq&mqC$+@+49v%%ySXSQ7DQ9JqEudpqB_r7*ma@4G-RZ=@tVUEjKNg2t+y8&_^4WmEN3Vg7HEv%BxR=K-3ubU2CEQ5-wDYn8WJY=?gKFW^RungZUZZ-zuNaYnqzWE-yQs2MMPq_6^dm7WkAxgGdeFFnr=SLD9VhM7u88gV6hp99EMJ&%gEvnJL^WfAhQndbzD&3X3Hhsx$QMMvMwRZ$Q&B7Qu7V8bQncxC=6RP^#epKA%VQYZp&2n7pNSp2pDVRFyewNGHx+59z+wDxWD9QRnxG%t^?!pak^5d9&8vRCntTJP%xuTfzZGxxT!&^4bCgjd^^pYXX33J@mw7REN#nBbPcDtn3EyRwh8SdQ-GK2BW$?_+ddp^k*=nwEa974mH&k*nygbEX4&Z4&QT+?_WS=+dK7tdK=#7^qmTRxjKNY=*+r9%8gcxMnr-rB4mFm2DwESmw!^Q7ufzVzaCjb-kw8!QV+SKWn&jt?-4nQLqhQQC@QP5%veaeHV$^-K$@9f6@=qyw!$JxPjmCs#_xb7a2xUjzWE_?N!A9ypBXQbq^ud+$Nz5Zh=fChhGHUPCHZQvu7sVBwg8Y-$6?u6JW#wFDFMH33wEa3LEELttbU?dx7sHCnSBx9smra5c5PByYDzvAS+tr_aejrN=NxMxf+2+m9x-x3Y*?ZQf&XS83B=mD2n2yx8qZMCRQrSGyEE@9Pqr-wYrGtLBD__p34@N#$B3nH&QPuMW8Vqz7w5Lxa?H9D7C3g^C3YXbbZTgxFCF+?kq@%X^GA8Mq#2^Nk9+#!w6YU4$5npYy3#?A&Kpv4YjYs?Kj&HH#+DVfU^gxxckmSu+jTkh5Fzb8v8xNyGs6Va$T6s7TPggKgcLKM!qp6VqXuLnLhY=&*qkjCTk$2w+nmB9C*GN2!JAA@7QgcR$AbB@jV6__Rwb%JQ?s7EHZ?XJW@s&ht$!qm3B$Y$fVCgFWPuCpT5^ra$JKJ!3$k^+9JSM&deMD@rdaP3!^FQWQ=D$&AaCT$*$Dvcv=A%?pz-cdqyf8tqJmCsF?JuFKc_-qAztc-eWVFtJRfbYd^e+UPRwaP7V9+W%$Jf!P3XRYzZLpCDHR#u!gjhV*_KE$pBKgYJa@a6^-c&pE=$4MKK8RxBNHGg&@EkbzW?BhWRzgB8=mqCN&YpMMxP4GgXj4gT!yGz^C*+_e=@wj8^tfLCyfzXLF*vWvkGg35S2k669B9h=6g?+bqu!5!Qry5e!BPVnZ%JPzws5aZcPPDhHvwJ?u+h?3%_7&_Ek=XPHWQ39MjR-M66LNFGEck#+tczcEws=fLz#qH2jMx3hpkeG%?A5&aCC@$#yQtxCQnX&VQV#ubqFv4?QPCUuWHb?dj?3fEk!h+U$v?F$4JMufC=WB4sL#GJ9TvBht3p=aN?C=+GpE*fxYe%g=7bh%Fc3sVJAGyRPV8ZH!Bt-vy7jxh#$C=vAdastKXJ8mSmY&pJsD2TK39jZLL=n5=nqWMUj-2dvP+8s-8Pmvm%N7&ZW*-s@$kZ2_5f7tw3DF%SV?hHcvSSKNfr8Rty8q$VxtPaZY@q_pRagGcKfbhnTW6ju-BELj&vGxxNZYyzxKpYGScsEB_37$Bnt!p@NdC@7VfmsCxN8_V_tKMj&9nt29fsGAUtr9X+S^q95XuE-CC@!dnhcKS-FBss-DRw-YHye*5*uwEG$@LAqdHrY*MS%Kf*qkr84xvzEgrcHU*B*8jVk=SdpRfRb%z4GK*!n?#Z=p#Bq@bN^nXMy$?V6wzgwu?QjLLXHP*d4bF*Ur2B?jF^npu4*bu$hHJU6fkdvGq&qfMC+*^Vgm$nkwQjHzxXT^pGEW$@#exT8RhL+f%kX%RZ$Rbter4BMp?*7rPzf4#xYky3UznUq37xwpuK+A#SE9e8AkKs%w=^+F?9m4hPRmyW%j%pqFYSRG8q7b*xEJuBFHxu8F2Nbayj#UAj_A_PCYGFG3sJ-gMB8X%*GDstbn4FnVCgN6EE38t4wtDPpxuS=$47$e+!v$JvZvBKMzRB';
END
GO
PRINT N'Création de Fonction [dbo].[GetPreSalt]...';


GO
CREATE FUNCTION [dbo].[GetPreSalt]
(
)
RETURNS NCHAR(2048)
AS
BEGIN
	RETURN N'MC+bqB3akr^JP$as!7z+Zq3$ZU7hxpvVTn5YpuB2+f4AUg@VcZUTX&ws@E6wz8qDW^ZkQQTY#N&@gs2ufZH-NK54qnYaB9VrW^c@TZmLAVb8a*JqPrHCz?kE-ZV?2yuZW-WN+K#cd@cfW?2CyWa-&d@RzA+ytPba?UZcuSxDu%Bj_JbXDktBk5hfyKTj@7uq%_*fenXCN396!7sHVxwZFKSRAPNMt*s3a@eqAhmxD@6?@B8kEGyWxwH+MX_8VXajUZHdZxTcjpCg@Xy2dsfC$sw#YwPGwKRyNp2#AFrT7pDJWSDx4XWvz2*9dRA7MPpqb5=kA@bre-jg2R%P2H7zmg9LpH%99Mg$?9$Hk?XPN@D6B%9Sp*q_2mjY8FdDKr!GTatNG_ucyz^4BczUZG*hKp$Kf$tPH@r_=BvjXvVRs856nUdM-?Va5Swu=LaETFHqfs?Xkx7HAqX=sqQdX%-L8+qpw&%UB+4rcte&$Y%B@A8H_F5mn_5qU=EHeHS--AZ3nWeY5SdWfhE#bxfYD#sLLZm#Nsm2Ke5GFARbWMUTNK8Qd@usAcAEpwp^-gc53m_pBDj6V+tm9e52BG7ehPnut?mj*6^wSh3R+FtRkKWvkdjVxL_zpAaTMNS$BMh-xfQh-^U6zuYtFULaUqhQu4PjR5Yp^WeUARNjh7Y%&Rej&XLzx5_nCB%48zutjRgLgdG4UZ&g!Sdcq2@y^FW9V+S&7wL_Ee-f3?vgeuT6CAKq?D8BFj5-c3YFqjrYmvu95uFEH@q+drjCrd%!6uZa!8MUnPpDxGBX$+K?rbWUYgxk6b=X^PB^Vnh#J2Dg&mGWWNs%d_s2+qguCmVEL6T!2=kP8qj5Ts8*BZW=V4j?38uqFmJKadd+=jz-+Jex3bQFp#w+GYdP#q^yfMcrLHV_RMa^qH#Zsu@E_+rwj@UYv$H=tCTSzcjW*-rH4VdsSB_wPG3PcF7NbCFeebrCTLbcAfV!YVzw?+BdABXbVk3W5QgHz2reyHQHFeDk32@MvMNecKNhLYtKW=G!jE65A6PhAeM$cbaJLjj6J25Z*yq%$G4?kV-AszPC?SnCfQ6CpYeqf7%?hu4G9uqZj8#@XB-v2S#*qufj7skwHCg9XdmUN33x%sY2hMb*#Y6+SAA$yGYbvXc2x%HFeAkE%+EddBHkYQ5^!f!&Y_=8k45bC8S*Z6NQZnZ?Ju#Cbyhf?+MTcvNWMfb%LRsZ=hge4ZH@K$z^bB=8bUQM+p?@-9QFPXWS#HT3N+cy?h-hsVR&B^8kXzecWwk?H#+6buh_meaEj8K7NtC#TGZ8w__M_v2vK?=p@Bg-Ww&R2tJX&^ENzqM^dTSQVdQ4zdJ*H+G3CPcxjnX_=zxDS&Zjs?dRuMX$86RFkz?^BVbUk-h3S7Dd-*TV8W4yyr9hg6A?UTer-*VDuEJMD!6bJs!!zAraz3y=UC%pyA8Y2Rwgu9K6$@KT8YN+hpE^S=as3R^K+JD5R-eXmW_8s5+ngvc*DHw&a9!pz8t!HZ7s^7Gs+YYvb6NJJnXP*8KtR^C?Bq87*EL#?Ktm&%h6Jn3VLu3uZk#@Fy_6atKtQH9pU?G&5z8RmKKx@ttrThYm8dcw2yM&gUXzkc=4JN?pwD9Nxd^&zV6s4Cqpw$#&Q4JJHyh$5mcbAMNSk*SybkXaJPyt33@T_!6bv4BL4zM@HfaewC*8#@Bt^8Pf3Cs+P$hk-EfRVRWrs+W$Ly?nnBk7qJk=*K5dkh%hrwGjSJmzcTb!pAzC@8&tLPFXv8Dvjr2wfB^CWLmSjnLDBpA5A7?89Gk&!vYUezhxJEcbXL28f!UAeum424*#Qj$xeWfRWMaam6-jR5R^jL4f_g8GN=YBp@mZB6!E&6ajbm_5sEm53e9khZ7PxwF^#&!k@&6TkuVYHETrN+Mu$J2XkqEEzC-75bU=*rML=A#sTJcXL+AMS@WFxR6X365GB$-Xp#kF%zLqp9!ZC3Z!Wtu5+2HxeUpEg7kxYcLP4PA97k7?SKu_SYZk_VVV582#HVN$wF3e%hM!eEE_Dggfx_aqf%kxegz=*5&4';
END
GO
PRINT N'Création de Procédure [dbo].[CheckUser]...';


GO
CREATE PROCEDURE [dbo].[CheckUser]
	@Email nvarchar(255),
	@MotDePasse varchar(255)
AS
Begin
	SELECT * --Id, Nom, Prenom, AdresseMail, RoleId
	from [Utilisateur] 
	where Email = @Email and MotDePasse = HASHBYTES('SHA2_512', dbo.GetPreSalt() + @MotDePasse + dbo.GetPostSalt());
End
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
	@Nom nvarchar(50),
	@Prenom nvarchar(50),
	@Email nvarchar(320),
	@Telephone varchar(20),
	@MotDePasse varchar(20),
	@Role varchar(20),
	@AdresseId int
AS
Begin
	Insert into [Utilisateur] ([Nom], [Prenom], [Email], [Telephone], [MotDePasse], [Role], [AdresseId])
	Values (@Nom, @Prenom, @Email, @Telephone, HASHBYTES('SHA2_512', dbo.GetPreSalt() + @MotDePasse + dbo.GetPostSalt()), @Role, @AdresseId);
End
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
