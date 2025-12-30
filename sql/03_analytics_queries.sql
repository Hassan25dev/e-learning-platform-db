MCD E-learning
 




/* ======================================================================
   Base de données : E-learning 3
   Description     : Modèle relationnel complet d'une plateforme de formation
   Auteur          : equipe certiport
   Date            : 07/11/2025
   ====================================================================== */

-- ======================================================================
-- 1️⃣ Création de la base et sélection du contexte
-- ======================================================================
CREATE DATABASE Elearn;
USE Elearn;

-- ======================================================================
-- 2️⃣ Création des tables principales
-- ======================================================================

-- ----------------------------
-- Table : Formateur
-- ----------------------------
CREATE TABLE Formateur (
    id_formateur INT PRIMARY KEY,
    nom VARCHAR(100),
    specialte VARCHAR(100)
);

-- ----------------------------
-- Table : Formation
-- Chaque formation est animée par un formateur
-- ----------------------------
CREATE TABLE Formation (
    id_formation INT PRIMARY KEY,
    titre VARCHAR(255),
    niveau VARCHAR(50),
    duree INT,
    id_formateur INT,
    FOREIGN KEY (id_formateur) REFERENCES Formateur(id_forrmateur)
);

-- ----------------------------
-- Table : Séquence
-- Découpe une formation en plusieurs parties pédagogiques
-- ----------------------------
CREATE TABLE Sequence (
    id_seq INT PRIMARY KEY,
    titre VARCHAR(255),
    duree INT,
    id_formation INT,
    id_formateur INT,
    FOREIGN KEY (id_formateur) REFERENCES Formateur(id_formateur),
    FOREIGN KEY (id_formation) REFERENCES Formation(id_formation)
);

-- ----------------------------
-- Table : Apprenant
-- ----------------------------
CREATE TABLE Apprenant (
    id_apprenant INT PRIMARY KEY,
    nom VARCHAR(100),
    email VARCHAR(100),
    date_inscription DATE
);

-- ----------------------------
-- Table : Inscription
-- Relation N:N entre Apprenant et Formation
-- ----------------------------
CREATE TABLE Inscription (
    id_apprenant INT,
    id_formation INT,
    date_debut DATE,
    statut VARCHAR(50),
    PRIMARY KEY (id_apprenant, id_formation),
    FOREIGN KEY (id_apprenant) REFERENCES Apprenant(id_apprenant),
    FOREIGN KEY (id_formation) REFERENCES Formation(id_formation)
);

-- ----------------------------
-- Table : Avis
-- Contient les retours des apprenants sur les formations
-- ----------------------------
CREATE TABLE Avis (
    id_avis INT PRIMARY KEY,
    id_apprenant INT,
    id_formation INT,
    note_avis INT,
    commentaire TEXT,
    FOREIGN KEY (id_apprenant) REFERENCES Apprenant(id_apprenant),
    FOREIGN KEY (id_formation) REFERENCES Formation(id_formation)
);

-- ----------------------------
-- Table : Paiement
-- Gère les paiements effectués pour chaque formation
-- ----------------------------
CREATE TABLE Paiement (
    id_paiment INT PRIMARY KEY,
    id_apprenant INT,
    id_formation INT,
    montant DECIMAL(10,2),
    date_paiment DATE,
    statut VARCHAR(50),
    ral_composel VARCHAR(100),
    FOREIGN KEY (id_apprenant) REFERENCES Apprenant(id_apprenant),
    FOREIGN KEY (id_formation) REFERENCES Formation(id_formation)
);

-- ----------------------------
-- Table : Évaluation
-- Notes attribuées à un apprenant pour une séquence donnée
-- ----------------------------
CREATE TABLE Evaluation (
    id_eval INT PRIMARY KEY,
    id_apprenant INT,
    id_formation INT,
    id_seq INT,
    note INT,
    date_eval DATE,
    FOREIGN KEY (id_apprenant) REFERENCES Apprenant(id_apprenant),
    FOREIGN KEY (id_seq) REFERENCES Sequence(id_seq),
    FOREIGN KEY (id_formation) REFERENCES Formation(id_formation)
);

-- ======================================================================
-- 🧾 3️⃣ Insertion des données initiales (exemples)
-- ======================================================================

-- ----------------------------
-- Formateurs
-- ----------------------------
INSERT INTO Formateur (id_formateur, nom, specialte)
VALUES 
(1, 'Loubna Mansouri', 'Cloud & Data'),
(2, 'Karim El Fassi', 'Sécurité Informatique'),
(3, 'Sarah Benali', 'IA & Machine Learning');

-- ----------------------------
-- Formations
-- ----------------------------
INSERT INTO Formation (id_formation, titre, niveau, duree, id_formateur)
VALUES 
(101, 'Azure Data Fundamentals', 'Débutant', 30, 1),
(102, 'Cybersécurité : Fondamentaux', 'Intermédiaire', 40, 2),
(103, 'Initiation au Machine Learning', 'Débutant', 35, 3);

-- ----------------------------
-- Séquences
-- ----------------------------
INSERT INTO Sequence (id_seq, titre, duree, id_formation, id_formateur)
VALUES 
(201, 'Bases de données relationnelles', 6, 101, 1),
(202, 'Stockage cloud et Azure', 8, 101, 1),
(203, 'Menaces numériques', 10, 102, 2),
(204, 'Chiffrement AES et RSA', 12, 102, 2),
(205, 'Nettoyage de données', 7, 103, 3),
(206, 'Régression linéaire', 9, 103, 3);

-- ----------------------------
-- Apprenants
-- ----------------------------
INSERT INTO Apprenant (id_apprenant, nom, email, date_inscription)
VALUES 
(1001, 'Outman BAZ', 'outman.baz@example.com', '2025-09-01'),
(1002, 'Youssef Amrani', 'youssef.a@example.com', '2025-09-03'),
(1003, 'Amina Zahidi', 'amina.z@example.com', '2025-09-05'),
(1004, 'Rachid Tazi', 'r.tazi@example.com', '2025-09-10');

-- ----------------------------
-- Inscriptions
-- ----------------------------
INSERT INTO Inscription (id_apprenant, id_formation, date_debut, statut)
VALUES 
(1001, 101, '2025-09-10', 'Confirmée'),
(1001, 102, '2025-10-01', 'En attente'),
(1002, 101, '2025-09-12', 'Confirmée'),
(1003, 103, '2025-09-18', 'Confirmée'),
(1004, 102, '2025-09-20', 'Confirmée');

-- ----------------------------
-- Avis
-- ----------------------------
INSERT INTO Avis (id_avis, id_apprenant, id_formation, note_avis, commentaire)
VALUES 
(4001, 1001, 101, 5, 'Parfait pour la certification DP-900 !'),
(4002, 1002, 101, 4, 'Bon contenu, mais quelques notions trop rapides.'),
(4003, 1003, 103, 5, 'Excellent ! Très clair pour les débutants.'),
(4004, 1004, 102, 4, 'Pratique et utile pour mon travail.');

-- ----------------------------
-- Paiements
-- ----------------------------
INSERT INTO Paiement (id_paiment, id_apprenant, id_formation, montant, date_paiment, statut, ral_composel)
VALUES 
(3001, 1001, 101, 299.99, '2025-09-05', 'Payé', 'CB-1001-101'),
(3002, 1002, 101, 299.99, '2025-09-10', 'Payé', 'CB-1002-101'),
(3003, 1003, 103, 349.99, '2025-09-15', 'Payé', 'VIR-1003-103'),
(3004, 1004, 102, 399.99, '2025-09-18', 'Payé', 'CB-1004-102');

-- ----------------------------
-- Évaluations
-- ----------------------------
INSERT INTO Evaluation (id_eval, id_apprenant, id_seq, note, date_eval, id_formation)
VALUES 
(6001, 1001, 201, 19, '2025-09-15', 101),
(6002, 1001, 202, 18, '2025-09-25', 101),
(6003, 1003, 205, 20, '2025-09-28', 103),
(6004, 1003, 206, 17, '2025-10-05', 103),
(6005, 1004, 203, 16, '2025-09-30', 102),
(6006, 1004, 204, 18, '2025-10-08', 102);

-- ======================================================================
-- 🔎 4️⃣ Requêtes d’analyse (indicateurs et rapports)
-- ======================================================================

-- 1️⃣ Lister les apprenants inscrits à chaque formation
-- 👉 Montre pour chaque formation la liste des apprenants et leur statut d'inscription

SELECT 
    f.titre AS formation,
    a.nom AS apprenant,
    i.statut
FROM Inscription i
JOIN Apprenant a ON i.id_apprenant = a.id_apprenant
JOIN Formation f ON i.id_formation = f.id_formation
ORDER BY f.titre, a.nom;

-- 🔽 Résultat attendu :
-- formation                     | apprenant               | statut
-- ---------------------------------------------------------------
-- Azure Data Fundamentals       | EnRetard1               | Confirmée
-- Azure Data Fundamentals       | Nouveau SansPaiement    | Confirmée
-- Azure Data Fundamentals       | Outman BAZ              | Confirmée
-- Azure Data Fundamentals       | Youssef Amrani          | Confirmée
-- Cybersécurité : Fondamentaux | Outman BAZ              | En attente
-- Cybersécurité : Fondamentaux | Rachid Tazi             | Confirmée
-- Initiation au Machine Learning| Amina Zahidi            | Confirmée

-- 2️⃣ Formations sans inscription confirmée 
-- 👉 Identifie les formations qui n'ont aucune inscription avec statut 'Confirmée'
-- (ici on ajoute volontairement une formation vide pour l'exemple)

INSERT INTO Formation (id_formation, titre, niveau, duree, id_formateur)
VALUES (104, 'Formation test vide', 'Débutant', 10, 1);

SELECT f.id_formation, f.titre
FROM Formation f
LEFT JOIN Inscription i ON f.id_formation = i.id_formation AND i.statut = 'Confirmée'
WHERE i.id_formation IS NULL;

-- 🔽 Résultat attendu :
-- id_formation | titre
-- -------------------------
-- 104          | Formation test vide

-- 3️⃣ Nombre de séquences par formation
-- 👉 Compte combien de séquences pédagogiques compose chaque formation
SELECT 
    f.titre,
    COUNT(s.id_seq) AS nb_sequences
FROM Formation f
LEFT JOIN Sequence s ON f.id_formation = s.id_formation
GROUP BY f.id_formation, f.titre;

-- 🔽 Résultat attendu :
-- titre                           | nb_sequences
-- --------------------------------------------
-- Azure Data Fundamentals         | 2
-- Cybersécurité : Fondamentaux    | 2
-- Initiation au Machine Learning  | 2
-- Formation test vide             | 0

-- 4️⃣ Formateurs les plus actifs
-- 👉 Classement des formateurs par nombre de formations animées
SELECT 
    fo.nom,
    fo.specialte,
    COUNT(f.id_formation) AS nb_formations
FROM Formateur fo
LEFT JOIN Formation f ON fo.id_formateur = f.id_formateur
GROUP BY fo.id_formateur, fo.nom, fo.specialte
ORDER BY nb_formations DESC;

-- 🔽 Résultat attendu :
-- nom               | specialte               | nb_formations
-- --------------------------------------------------------
-- Loubna Mansouri   | Cloud & Data            | 2
-- Karim El Fassi    | Sécurité Informatique   | 1
-- Sarah Benali      | IA & Machine Learning   | 1

-- 5️⃣ Apprenants sans paiement
-- 👉 Liste les apprenants qui n'ont aucun enregistrement de paiement
-- (le script ajoute des apprenants 'Nouveau SansPaiement' et 'EnRetard1' pour l'exemple)
INSERT INTO Apprenant (id_apprenant, nom, email, date_inscription)
VALUES (1005, 'Nouveau SansPaiement', 'test@example.com', '2025-11-01');
INSERT INTO Inscription (id_apprenant, id_formation, date_debut, statut)
VALUES (1005, 101, '2025-11-05', 'Confirmée');

SELECT a.id_apprenant, a.nom, a.email
FROM Apprenant a
LEFT JOIN Paiement p ON a.id_apprenant = p.id_apprenant
WHERE p.id_paiment IS NULL;

-- 🔽 Résultat attendu :
-- id_apprenant | nom                | emall
-- -------------------------------------------
-- 1005         | Nouveau SansPaiement | test@example.com
-- 1006         | EnRetard1           | retard1@example.com

-- 6️⃣ Apprenants en retard de paiement
-- 👉 Identifie les inscriptions confirmées sans paiement ou avec paiement non-payé

INSERT INTO Apprenant (id_apprenant, nom, email, date_inscription)
VALUES (1006, 'EnRetard1', 'retard1@example.com', '2025-11-01');
INSERT INTO Inscription (id_apprenant, id_formation, date_debut, statut)
VALUES (1006, 101, '2025-11-05', 'Confirmée');
INSERT INTO Paiement (id_paiment, id_apprenant, id_formation, montant, date_paiment, statut, ral_composel)
VALUES (3005, 1001, 102, 399.99, '2025-10-01', 'En attente', 'CB-1001-102');

SELECT DISTINCT a.id_apprenant, a.nom, a.email, f.titre
FROM Inscription i
JOIN Apprenant a ON i.id_apprenant = a.id_apprenant
JOIN Formation f ON i.id_formation = f.id_formation
LEFT JOIN Paiement p ON i.id_apprenant = p.id_apprenant AND i.id_formation = p.id_formation
WHERE i.statut = 'Confirmée'
  AND (p.id_paiment IS NULL OR p.statut != 'Payé');

-- 🔽 Résultat attendu :
-- id_apprenant | nom               | emall               | titre
-- ---------------------------------------------------------------
-- 1005         | Nouveau SansPaiement | test@example.com    | Azure Data Fundamentals
-- 1006         | EnRetard1           | retard1@example.com | Azure Data Fundamentals

-- 7️⃣ Taux de réussite moyen par formation
-- 👉 Moyenne des notes et pourcentage de réussite (note >= 10 considéré comme réussite)
SELECT 
    f.titre,
    ROUND(AVG(e.note), 2) AS moyenne_notes,
    ROUND(AVG(CASE WHEN e.note >= 10 THEN 100.0 ELSE 0 END), 2) AS taux_reussite_percent
FROM Formation f
JOIN Evaluation e ON f.id_formation = e.id_formation
GROUP BY f.id_formation, f.titre;

-- 🔽 Résultat attendu :
-- titre                          | moyenne_notes | taux_reussite_percent
-- ---------------------------------------------------------------
-- Azure Data Fundamentals        | 18            | 100.00
-- Cybersécurité : Fondamentaux  | 17            | 100.00
-- Initiation au Machine Learning| 18            | 100.00

-- 8️⃣ Moyenne des notes par formateur
-- 👉 Moyenne des notes obtenues pour les formations d'un formateur
SELECT 
    fo.nom AS formateur,
    fo.specialte,
    ROUND(AVG(e.note), 2) AS moyenne_notes
FROM Formateur fo
JOIN Formation f ON fo.id_formateur = f.id_formateur
JOIN Evaluation e ON f.id_formation = e.id_formation
GROUP BY fo.id_formateur, fo.nom, fo.specialte;

-- 🔽 Résultat attendu :
-- formateur          | specialte               | moyenne_notes
-- ---------------------------------------------------------
-- Loubna Mansouri    | Cloud & Data            | 18
-- Karim El Fassi     | Sécurité Informatique   | 17
-- Sarah Benali       | IA & Machine Learning   | 18

-- 9️⃣ Taux de satisfaction moyen par formation
-- 👉 Moyenne des notes d'avis par formation
SELECT 
    f.titre,
    ROUND(AVG(av.note_avis), 2) AS satisfaction_moyenne
FROM Formation f
JOIN Avis av ON f.id_formation = av.id_formation
GROUP BY f.id_formation, f.titre;

-- 🔽 Résultat attendu :
-- titre                          | satisfaction_moyenne
-- ------------------------------------------------
-- Initiation au Machine Learning | 5
-- Azure Data Fundamentals        | 4
-- Cybersécurité : Fondamentaux  | 4


-- 🔟 Total des montants payés par apprenant
-- 👉 Montant total payé par apprenant (seulement les paiements 'Payé')
SELECT 
    a.id_apprenant,
    a.nom,
    SUM(p.montant) AS total_paye
FROM Apprenant a
JOIN Paiement p ON a.id_apprenant = p.id_apprenant
WHERE p.statut = 'Payé'
GROUP BY a.id_apprenant, a.nom;

-- 🔽 Résultat attendu :
-- id_apprenant | nom           | total_paye
-- ------------------------------------------
-- 1001         | Outman BAZ    | 299.99
-- 1002         | Youssef Amrani| 299.99
-- 1003         | Amina Zahidi  | 349.99
-- 1004         | Rachid Tazi   | 399.99

-- 11️⃣ Classement des formations selon la satisfaction moyenne
SELECT 
    f.titre,
    ROUND(AVG(av.note_avis), 2) AS satisfaction_moyenne
FROM Formation f
JOIN Avis av ON f.id_formation = av.id_formation
GROUP BY f.id_formation, f.titre
ORDER BY satisfaction_moyenne DESC;

-- 🔽 Résultat attendu :
-- titre                          | satisfaction_moyenne
-- ------------------------------------------------
-- Initiation au Machine Learning | 5
-- Azure Data Fundamentals        | 4
-- Cybersécurité : Fondamentaux  | 4


-- ======================================================================
-- ======================================================================
-- 5️⃣ Indicateurs synthétiques (tableau de bord métier)
-- ======================================================================

-- 📊 1. Taux de réussite
-- 🔹 Définition
-- Pourcentage d’évaluations réussies (note ≥ seuil) par rapport au total des évaluations passées, par formation (ou globalement).
-- 🔹 Données sources
-- •   Table Evaluation : colonnes note, id_formation, id_apprenant
-- •   Hypothèse : échelle sur 20, seuil de réussite = 10/20
-- 🔹 Exemple SQL (par formation)
SELECT 
    f.titre,
    ROUND(
        COUNT(CASE WHEN e.note >= 10 THEN 1 END) * 100.0 / COUNT(*),
        2
    ) AS taux_reussite_percent
FROM Formation f
JOIN Evaluation e ON f.id_formation = e.id_formation
GROUP BY f.id_formation, f.titre;

-- 🔽 Résultat attendu :
-- titre                          | taux_reussite_percent
-- ----------------------------------------------------
-- Azure Data Fundamentals        | 100.00
-- Cybersécurité : Fondamentaux  | 100.00
-- Initiation au Machine Learning| 100.00


-- 😊 2. Taux de satisfaction
-- 🔹 Définition
-- Moyenne des notes d’avis laissés par les apprenants sur une formation, généralement sur une échelle de 1 à 5.
-- 🔹 Données sources
-- •   Table Avis : colonnes note_avis, id_formation
-- •   Table Formation : pour le libellé
-- 🔹 Exemple SQL
SELECT 
    f.titre,
    ROUND(AVG(a.note_avis), 2) AS satisfaction_moyenne,
    COUNT(a.id_avis) AS nb_avis
FROM Formation f
JOIN Avis a ON f.id_formation = a.id_formation
GROUP BY f.id_formation, f.titre;

-- 🔽 Résultat attendu :
-- titre                          | satisfaction_moyenne | nb_avis
-- ---------------------------------------------------------------
-- Azure Data Fundamentals        | 4.50                 | 2
-- Cybersécurité : Fondamentaux  | 4.00                 | 1
-- Initiation au Machine Learning| 5.00                 | 1


-- 💸 3. Liste des retards de paiement
-- 🔹 Définition
-- Apprenants dont l’inscription est confirmée mais pour lesquels aucun paiement n’est enregistré 
-- ou le statut du paiement n’est pas "Payé".
-- 🔹 Données sources
-- •   Table Inscription : statut = 'Confirmée'
-- •   Table Paiement : statut (ex. : 'Payé', 'En attente', 'Échoué')
-- •   Liaison via (id_apprenant, id_formation)
-- 🔹 Indicateurs dérivés
-- •   Nombre d’apprenants en retard
-- •   Taux de retard = (inscriptions confirmées sans paiement valide) / (total inscriptions confirmées)
-- •   Montant total en retard (si on connaît le montant attendu par formation)
-- 🔹 Exemple SQL (liste des cas en retard)
SELECT 
    a.nom,
    a.email,  -- ✅ corrigé : "emall" → "email"
    f.titre AS formation,
    i.date_debut
FROM Inscription i
JOIN Apprenant a ON i.id_apprenant = a.id_apprenant
JOIN Formation f ON i.id_formation = f.id_formation
LEFT JOIN Paiement p ON i.id_apprenant = p.id_apprenant AND i.id_formation = p.id_formation
WHERE i.statut = 'Confirmée'
  AND (p.id_paiement IS NULL OR p.statut != 'Payé');  -- ✅ corrigé : "id_paiment" → "id_paiement"

-- 🔽 Résultat attendu :
-- nom                  | email                | formation                 | date_debut
-- -------------------------------------------------------------------------------
-- Nouveau SansPaiement | test@example.com     | Azure Data Fundamentals   | 2025-11-05
-- EnRetard1            | retard1@example.com  | Azure Data Fundamentals   | 2025-11-05


-- ✅ Taux global de retard de paiement
-- 🔹 Formule : (nb inscriptions confirmées non payées) / (total inscriptions confirmées) × 100
SELECT 
    ROUND(
        COUNT(CASE WHEN p.id_paiement IS NULL OR p.statut != 'Payé' THEN 1 END) * 100.0 / COUNT(*),
        2
    ) AS taux_retard_percent
FROM Inscription i
LEFT JOIN Paiement p ON i.id_apprenant = p.id_apprenant AND i.id_formation = p.id_formation
WHERE i.statut = 'Confirmée';

-- 🔽 Résultat attendu :
-- taux_retard_percent
-- -------------------
-- 33.33