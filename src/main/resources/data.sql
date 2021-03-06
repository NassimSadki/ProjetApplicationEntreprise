SET FOREIGN_KEY_CHECKS = 0; 
TRUNCATE TABLE categorie_panier;
TRUNCATE TABLE categorie_commercant;
TRUNCATE TABLE commercant;
TRUNCATE TABLE panier;
TRUNCATE TABLE role;
SET FOREIGN_KEY_CHECKS = 1; 
INSERT INTO categorie_panier(categorie) VALUES("CategoriePanier1"),("CategoriePanier2"),("CategoriePanier3"),("CategoriePanier4"),("CategoriePanier5");
INSERT INTO categorie_commercant(categorie) VALUES("CategorieCommercant1"),("CategorieCommercant2"),("CategorieCommercant3");
INSERT INTO commercant(localisation,nom,categorie_commercant_id) VALUES ("Localisation1","Commercant1",1),("Localisation2","Commercant2",1),("Localisation3","Commercant3",2),("Localisation4","Commercant4",3),("Localisation5","Commercant5",2),("Localisation6","Commercant6",1),("Localisation7","Commercant7",3),("Localisation8","Commercant8",2),("Localisation9","Commercant9",3),("Localisation10","Commercant10",2);
INSERT INTO panier(description,nom,prix,categorie_panier_id,commercant_id) VALUES ("Description1","Nom1",15.99,1,1),("Description2","Nom2",20.5,2,8),("Description3","Nom3",4.99,5,3),("Description4","Nom4",35.0,2,6),("Description5","Nom5",15.0,5,2);
INSERT INTO role(name) VALUES ("USER"),("ADMIN");