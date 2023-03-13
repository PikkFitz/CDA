-- 1 - Créez trois utilisateurs util1, util2, util3 pour la base papyrus --

CREATE USER 'util1'@'localhost' IDENTIFIED BY 'mdp_util1';
CREATE USER 'util2'@'localhost' IDENTIFIED BY 'mdp_util2';
CREATE USER 'util3'@'localhost' IDENTIFIED BY 'mdp_util3';


-- 2 - util1 doit pouvoir effectuer toutes les actions --

GRANT ALL PRIVILEGES ON papyrus.* TO 'util1'@'localhost';


-- 3 - util2 ne peut que sélectionner les informations dans la base --

GRANT SELECT ON papyrus.* TO 'util2'@'localhost';


-- 4 - util3 n'a aucun droit sur la base de données, sauf d'afficher la table fournis --

GRANT SELECT ON papyrus.fournis TO 'util3'@'localhost';