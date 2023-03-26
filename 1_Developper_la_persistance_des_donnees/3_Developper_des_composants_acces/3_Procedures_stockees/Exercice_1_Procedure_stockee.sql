-- Exercice 1 : création d'une procédure stockée sans paramètre --------------------------------------------------------------

-- 1. Créez la procédure stockée Lst_fournis correspondant à la requête n°2 "afficher le code des fournisseurs pour lesquels une commande a été passée" -----

DROP PROCEDURE IF EXISTS `Lst_fournis`;

DELIMITER |

CREATE PROCEDURE Lst_fournis()

BEGIN
   SELECT DISTINCT numfou AS 'Numéro fournisseur'
   FROM entcom;
END |

DELIMITER ;

-- 2. Exécutez la pour vérifier qu’elle fonctionne conformément à votre attente --------------------------------------------------------

-- A FAIRE DIRECTEMENT SUR PHP MYADMIN DANS L'ONGLET "PROCEDURES STOCKEES" ET CLIQUER SUR "EXECUTER" SUR LA PROCEDURE DESIREE


-- 3. Exécutez la commande SQL suivante pour obtenir des informations sur cette procédure stockée : ------------------------------------

-- SHOW CREATE PROCEDURE nom_procedure; -- --> 
SHOW CREATE PROCEDURE Lst_fournis;