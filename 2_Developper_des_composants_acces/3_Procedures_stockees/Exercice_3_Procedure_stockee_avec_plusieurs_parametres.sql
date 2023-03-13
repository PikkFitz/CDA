-- Exercice 3 : création d'une procédure stockée avec plusieurs paramètres --------------------------------------------------------------

-- Créer la procédure stockée CA_Fournisseur, qui pour un code fournisseur et une année entrée en paramètre, 
-- calcule et restitue le CA potentiel de ce fournisseur pour l'année souhaitée 
-- (cette requête sera construite à partir de la requête n°19)
-- On exécutera la requête que si le code fournisseur est valide, c'est-à-dire dans la table FOURNIS
-- Testez cette procédure avec différentes valeurs des paramètres

DROP PROCEDURE IF EXISTS `CA_Fournisseur`;

DELIMITER |

CREATE PROCEDURE CA_Fournisseur(
   In codfou varchar(50),
   In dateCommande varchar(50)
   )

BEGIN

SELECT f.numfou AS 'Numéro fournisseur', f.nomfou AS 'Nom du fournisseur', SUM((l.qtecde * l.priuni)*0.80) AS 'Chiffre d\'affaire'
FROM fournis f
JOIN entcom e ON f.numfou = e.numfou
JOIN ligcom l ON e.numcom = l.numcom
WHERE f.numfou LIKE codfou AND YEAR(e.datcom) = dateCommande;

END |

DELIMITER ;

-- Pour exécuter avec une valeur de paramètre :
CALL Lst_Commandes(120, 2018);

-- Liste des procédures stockées :
SHOW PROCEDURE STATUS;

-- Supprimer une procédure :
DROP PROCEDURE nom_procedure;

