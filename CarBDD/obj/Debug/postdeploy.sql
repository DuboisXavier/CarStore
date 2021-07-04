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
