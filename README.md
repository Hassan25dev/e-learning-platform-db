# 📚 Plateforme E-Learning – Modèle de Base de Données

> **Projet académique** : Conception complète d'une base de données relationnelle pour une plateforme de formation en ligne  
> **Du MCD au SQL** avec extraction d'indicateurs clés : **taux de réussite**, **satisfaction apprenants**, **retards de paiement**

[![MCD E-Learning](./docs/mcd_elearning.png)](./docs/mcd_elearning.png)

---

## 🎯 Objectifs du projet

Créer une base de données normalisée et performante pour une plateforme e-learning, capable de :

- Gérer **apprenants**, **formateurs**, **formations**, **inscriptions**, **évaluations**, **avis** et **paiements**
- Générer des **KPI métier** en temps réel
- Respecter les **bonnes pratiques** de modélisation (normalisation 3NF, intégrité référentielle)

---

## 🗃️ Structure du projet

e-learning-platform-db/

├── docs/

│ ├── mcd_elearning.png # Schéma conceptuel (MCD)

│ └── mld_description.md # Modèle logique détaillé (MLD)

└── sql/

├── 01_schema.sql # 🎛️ Création tables + contraintes

├── 02_seed_data.sql # 🌱 Données d'exemple réalistes

└── 03_analytics_queries.sql # 📈 Requêtes KPI + résultats


---

## 📊 Indicateurs clés implémentés

### 1. **Taux de réussite par formation**

SELECT f.titre,
ROUND(COUNT(CASE WHEN e.note >= 10 THEN 1 END) * 100.0 / COUNT(*), 2) AS taux_reussite_percent
FROM Formation f
JOIN Evaluation e ON f.id_formation = e.id_formation
GROUP BY f.id_formation, f.titre
ORDER BY taux_reussite_percent DESC;


### 2. **Taux de satisfaction moyenne**

SELECT f.titre,
ROUND(AVG(a.note_avis), 2) AS satisfaction_moyenne,
COUNT(a.id_avis) AS nb_avis
FROM Formation f
JOIN Avis a ON f.id_formation = a.id_formation
GROUP BY f.id_formation, f.titre
HAVING COUNT(a.id_avis) >= 5
ORDER BY satisfaction_moyenne DESC;


### 3. **Apprenants en retard de paiement**

SELECT a.nom, a.prenom, a.email, f.titre,
DATEDIFF(CURDATE(), i.date_inscription) AS jours_retard
FROM Inscription i
JOIN Apprenant a ON i.id_apprenant = a.id_apprenant
JOIN Formation f ON i.id_formation = f.id_formation
LEFT JOIN Paiement p ON i.id_inscription = p.id_inscription
WHERE i.statut = 'Confirmée'
AND (p.id_paiement IS NULL OR p.statut != 'Payé')
ORDER BY jours_retard DESC;


---

## ⚙️ Bonnes pratiques appliquées

- **Normalisation 3NF** : Élimination des redondances, dépendances fonctionnelles respectées
- **Intégrité référentielle** : Clés étrangères avec `CASCADE`, contraintes `CHECK`
- **Performance** : Index sur colonnes fréquemment jointes (`id_formation`, `id_apprenant`)
- **Sécurité** : Contraintes sur notes (0-20), statuts enumérés
- **Documentation** : MCD visuel, MLD textuel, requêtes commentées

---

## 🚀 Installation & Exécution

### Prérequis

MySQL 8.0+ ou MariaDB 10.5+

### Étapes

-- 1. Créer la base

CREATE DATABASE Elearn CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE Elearn;

-- 2. Exécuter les scripts (dans l'ordre)

SOURCE sql/01_schema.sql;
SOURCE sql/02_seed_data.sql;
SOURCE sql/03_analytics_queries.sql;


**✅ Résultat attendu** : 5 formations, 50 apprenants, 200 évaluations, KPI fonctionnels

---

## 📈 Résultats des KPI (exemple données seed)

| Formation | Taux réussite | Satisfaction | Retards paiement |
|-----------|---------------|--------------|------------------|
| Python Avancé | 78.6% | 4.3/5 | 3 apprenants |
| SQL Expert | 92.1% | 4.7/5 | 0 apprenant |
| Data Viz | 65.4% | 3.8/5 | 7 apprenants |

---

## 🌟 Compétences démontrées

- **Analyse métier** → Modélisation conceptuelle (MCD)
- **Normalisation** → Modèle logique (MLD) → Implémentation physique
- **SQL avancé** : Jointures complexes, agrégations, sous-requêtes
- **KPI métier** : Traduction besoins business → requêtes exploitables
- **Documentation** : Schémas visuels + code commenté

---

## 👨‍💻 Auteur

**Hassane Amanad**  
💼 Full-stack developer trainee | Data Analyst  
📍 Casablanca, Maroc  
🌐 [GitHub @Hassan25dev](https://github.com/Hassan25dev)  

*Contexte : Projet académique @AI-institute-jobintech*

---

## 📄 Licence

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

---

*⭐ N'hésite pas à star si ce projet t'aide ! Contributions bienvenues.*

