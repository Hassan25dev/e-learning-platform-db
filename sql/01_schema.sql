-- ======================================================================
-- 01_schema.sql
-- Modèle logique de la plateforme e-learning
-- Tables, clés primaires, clés étrangères
-- ======================================================================

-- Création de la base de données
CREATE DATABASE IF NOT EXISTS Elearn;
USE Elearn;

-- Table Formateur
CREATE TABLE Formateur (
    id_formateur INT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    specialite VARCHAR(100)
);

-- Table Formation
CREATE TABLE Formation (
    id_formation INT PRIMARY KEY,
    titre VARCHAR(255) NOT NULL,
    niveau VARCHAR(50),
    duree INT,
    id_formateur INT,
    FOREIGN KEY (id_formateur) REFERENCES Formateur(id_formateur)
);

-- Table Séquence (découpage pédagogique d'une formation)
CREATE TABLE Sequence (
    id_seq INT PRIMARY KEY,
    titre VARCHAR(255) NOT NULL,
    duree INT,
    id_formation INT,
    FOREIGN KEY (id_formation) REFERENCES Formation(id_formation)
);

-- Table Apprenant
CREATE TABLE Apprenant (
    id_apprenant INT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    date_inscription DATE
);

-- Table Inscription (relation N-N entre Apprenant et Formation)
CREATE TABLE Inscription (
    id_apprenant INT,
    id_formation INT,
    date_debut DATE,
    statut VARCHAR(50) DEFAULT 'En attente',
    PRIMARY KEY (id_apprenant, id_formation),
    FOREIGN KEY (id_apprenant) REFERENCES Apprenant(id_apprenant),
    FOREIGN KEY (id_formation) REFERENCES Formation(id_formation)
);

-- Table Avis (retours qualitatifs et notes)
CREATE TABLE Avis (
    id_avis INT PRIMARY KEY,
    id_apprenant INT,
    id_formation INT,
    note_avis INT CHECK (note_avis BETWEEN 1 AND 5),
    commentaire TEXT,
    FOREIGN KEY (id_apprenant) REFERENCES Apprenant(id_apprenant),
    FOREIGN KEY (id_formation) REFERENCES Formation(id_formation)
);

-- Table Paiement
CREATE TABLE Paiement (
    id_paiement INT PRIMARY KEY,
    id_apprenant INT,
    id_formation INT,
    montant DECIMAL(10,2) NOT NULL,
    date_paiement DATE,
    statut VARCHAR(50) DEFAULT 'En attente', -- 'Payé', 'Échoué', 'En attente'
    ref_paiement VARCHAR(100), -- Référence unique (CB, virement, etc.)
    FOREIGN KEY (id_apprenant) REFERENCES Apprenant(id_apprenant),
    FOREIGN KEY (id_formation) REFERENCES Formation(id_formation)
);

-- Table Évaluation (notes par séquence)
CREATE TABLE Evaluation (
    id_eval INT PRIMARY KEY,
    id_apprenant INT,
    id_formation INT,
    id_seq INT,
    note INT CHECK (note BETWEEN 0 AND 20),
    date_eval DATE,
    FOREIGN KEY (id_apprenant) REFERENCES Apprenant(id_apprenant),
    FOREIGN KEY (id_seq) REFERENCES Sequence(id_seq),
    FOREIGN KEY (id_formation) REFERENCES Formation(id_formation)
);