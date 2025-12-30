-- ======================================================================
-- 02_seed_data.sql
-- Données d'exemple pour la plateforme e-learning
-- ======================================================================

USE Elearn;

-- Formateurs
INSERT INTO Formateur (id_formateur, nom, specialite) VALUES 
(1, 'Loubna Mansouri', 'Cloud & Data'),
(2, 'Karim El Fassi', 'Sécurité Informatique'),
(3, 'Sarah Benali', 'IA & Machine Learning');

-- Formations
INSERT INTO Formation (id_formation, titre, niveau, duree, id_formateur) VALUES 
(101, 'Azure Data Fundamentals', 'Débutant', 30, 1),
(102, 'Cybersécurité : Fondamentaux', 'Intermédiaire', 40, 2),
(103, 'Initiation au Machine Learning', 'Débutant', 35, 3);

-- Séquences pédagogiques
INSERT INTO Sequence (id_seq, titre, duree, id_formation) VALUES 
(201, 'Bases de données relationnelles', 6, 101),
(202, 'Stockage cloud et Azure', 8, 101),
(203, 'Menaces numériques', 10, 102),
(204, 'Chiffrement AES et RSA', 12, 102),
(205, 'Nettoyage de données', 7, 103),
(206, 'Régression linéaire', 9, 103);

-- Apprenants
INSERT INTO Apprenant (id_apprenant, nom, email, date_inscription) VALUES 
(1001, 'Outman BAZ', 'outman.baz@example.com', '2025-09-01'),
(1002, 'Youssef Amrani', 'youssef.a@example.com', '2025-09-03'),
(1003, 'Amina Zahidi', 'amina.z@example.com', '2025-09-05'),
(1004, 'Rachid Tazi', 'r.tazi@example.com', '2025-09-10');

-- Inscriptions
INSERT INTO Inscription (id_apprenant, id_formation, date_debut, statut) VALUES 
(1001, 101, '2025-09-10', 'Confirmée'),
(1001, 102, '2025-10-01', 'En attente'),
(1002, 101, '2025-09-12', 'Confirmée'),
(1003, 103, '2025-09-18', 'Confirmée'),
(1004, 102, '2025-09-20', 'Confirmée');

-- Avis
INSERT INTO Avis (id_avis, id_apprenant, id_formation, note_avis, commentaire) VALUES 
(4001, 1001, 101, 5, 'Parfait pour la certification DP-900 !'),
(4002, 1002, 101, 4, 'Bon contenu, mais quelques notions trop rapides.'),
(4003, 1003, 103, 5, 'Excellent ! Très clair pour les débutants.'),
(4004, 1004, 102, 4, 'Pratique et utile pour mon travail.');

-- Paiements
INSERT INTO Paiement (id_paiement, id_apprenant, id_formation, montant, date_paiement, statut, ref_paiement) VALUES 
(3001, 1001, 101, 299.99, '2025-09-05', 'Payé', 'CB-1001-101'),
(3002, 1002, 101, 299.99, '2025-09-10', 'Payé', 'CB-1002-101'),
(3003, 1003, 103, 349.99, '2025-09-15', 'Payé', 'VIR-1003-103'),
(3004, 1004, 102, 399.99, '2025-09-18', 'Payé', 'CB-1004-102');

-- Évaluations
INSERT INTO Evaluation (id_eval, id_apprenant, id_seq, note, date_eval, id_formation) VALUES 
(6001, 1001, 201, 19, '2025-09-15', 101),
(6002, 1001, 202, 18, '2025-09-25', 101),
(6003, 1003, 205, 20, '2025-09-28', 103),
(6004, 1003, 206, 17, '2025-10-05', 103),
(6005, 1004, 203, 16, '2025-09-30', 102),
(6006, 1004, 204, 18, '2025-10-08', 102);

-- Données supplémentaires pour tester les cas limites
INSERT INTO Formation (id_formation, titre, niveau, duree, id_formateur)
VALUES (104, 'Formation test vide', 'Débutant', 10, 1);

INSERT INTO Apprenant (id_apprenant, nom, email, date_inscription) VALUES 
(1005, 'Nouveau SansPaiement', 'test@example.com', '2025-11-01'),
(1006, 'EnRetard1', 'retard1@example.com', '2025-11-01');

INSERT INTO Inscription (id_apprenant, id_formation, date_debut, statut) VALUES 
(1005, 101, '2025-11-05', 'Confirmée'),
(1006, 101, '2025-11-05', 'Confirmée');

INSERT INTO Paiement (id_paiement, id_apprenant, id_formation, montant, date_paiement, statut, ref_paiement)
VALUES (3005, 1001, 102, 399.99, '2025-10-01', 'En attente', 'CB-1001-102');