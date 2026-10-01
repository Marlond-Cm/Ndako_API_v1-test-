-- ============================================================
-- NDAKO TECH - DONNÉES DE TEST
-- Fichier : seed.sql
-- ============================================================

-- ============================================================
-- 1. VILLES
-- ============================================================

INSERT INTO ville (nom)
VALUES
    ('Brazzaville'),
    ('Pointe-Noire');


-- ============================================================
-- 2. QUARTIERS
-- ============================================================

-- Brazzaville
INSERT INTO quartier (ville_id, nom)
VALUES
    (1, 'Moungali'),
    (1, 'Bacongo'),
    (1, 'Talangaï'),
    (1, 'Poto-Poto'),
    (1, 'Makélékélé'),
    (1, 'Mfilou');

-- Pointe-Noire
INSERT INTO quartier (ville_id, nom)
VALUES
    (2, 'Tié-Tié'),
    (2, 'Loandjili'),
    (2, 'Lumumba'),
    (2, 'Mongo-Mpoukou'),
    (2, 'Mvoumvou'),
    (2, 'Ngoyo');


-- ============================================================
-- 3. UTILISATEURS / PROPRIÉTAIRES
-- ============================================================

INSERT INTO utilisateur (nom, prenom, telephone, statut)
VALUES
    ('MABIALA', 'Jean', '0600000001', 'actif'),
    ('NGOMA', 'Patrick', '0600000002', 'actif'),
    ('MOUSSAVOU', 'Clarisse', '0600000003', 'actif'),
    ('KOUILOU', 'Franck', '0600000004', 'actif'),
    ('MBOUKOU', 'Alain', '0600000005', 'actif'),
    ('NZAMBA', 'Estelle', '0600000006', 'actif');


-- ============================================================
-- 4. LOGEMENTS
-- ============================================================

-- ------------------------------------------------------------
-- Brazzaville - Moungali
-- Disponible / Vérifié / Avec photos
-- Loyer : 150 000 FCFA
-- Caution : 2 mois
-- ------------------------------------------------------------

INSERT INTO logement (
    user_id,
    quartier_id,
    titre,
    description,
    adresse,
    type_bien,
    loyer,
    caution_mois,
    eau_courante,
    compteur_electrique,
    statut,
    verifie
)
VALUES (
    1,
    1,
    'Appartement moderne à Moungali',
    'Appartement propre situé dans un quartier accessible.',
    'Moungali, Brazzaville',
    'appartement',
    150000,
    2,
    TRUE,
    TRUE,
    'disponible',
    TRUE
);


-- ------------------------------------------------------------
-- Brazzaville - Bacongo
-- Disponible / Non vérifié / SANS PHOTO
-- Caution inconnue
-- ------------------------------------------------------------

INSERT INTO logement (
    user_id,
    quartier_id,
    titre,
    description,
    adresse,
    type_bien,
    loyer,
    caution_mois,
    eau_courante,
    compteur_electrique,
    statut,
    verifie
)
VALUES (
    2,
    2,
    'Studio à Bacongo',
    'Petit studio adapté à une personne seule.',
    'Bacongo, Brazzaville',
    'studio',
    80000,
    NULL,
    TRUE,
    FALSE,
    'disponible',
    FALSE
);


-- ------------------------------------------------------------
-- Brazzaville - Talangaï
-- Disponible / Vérifié / Avec photos
-- Loyer : 250 000 FCFA
-- Caution : 3 mois
-- ------------------------------------------------------------

INSERT INTO logement (
    user_id,
    quartier_id,
    titre,
    description,
    adresse,
    type_bien,
    loyer,
    caution_mois,
    eau_courante,
    compteur_electrique,
    statut,
    verifie
)
VALUES (
    3,
    3,
    'Maison familiale à Talangaï',
    'Maison spacieuse avec plusieurs pièces.',
    'Talangaï, Brazzaville',
    'maison',
    250000,
    3,
    TRUE,
    TRUE,
    'disponible',
    TRUE
);


-- ------------------------------------------------------------
-- Brazzaville - Poto-Poto
-- OCCUPÉ
-- Ce logement doit être exclu des résultats disponibles.
-- ------------------------------------------------------------

INSERT INTO logement (
    user_id,
    quartier_id,
    titre,
    description,
    adresse,
    type_bien,
    loyer,
    caution_mois,
    eau_courante,
    compteur_electrique,
    statut,
    verifie
)
VALUES (
    4,
    4,
    'Appartement à Poto-Poto',
    'Appartement actuellement occupé.',
    'Poto-Poto, Brazzaville',
    'appartement',
    180000,
    2,
    TRUE,
    TRUE,
    'occupe',
    TRUE
);


-- ------------------------------------------------------------
-- Brazzaville - Makélékélé
-- Disponible / Non vérifié
-- ------------------------------------------------------------

INSERT INTO logement (
    user_id,
    quartier_id,
    titre,
    description,
    adresse,
    type_bien,
    loyer,
    caution_mois,
    eau_courante,
    compteur_electrique,
    statut,
    verifie
)
VALUES (
    5,
    5,
    'Chambre simple à Makélékélé',
    'Chambre simple destinée à une personne.',
    'Makélékélé, Brazzaville',
    'chambre',
    50000,
    1,
    FALSE,
    TRUE,
    'disponible',
    FALSE
);


-- ------------------------------------------------------------
-- Brazzaville - Mfilou
-- Disponible / Vérifié
-- ------------------------------------------------------------

INSERT INTO logement (
    user_id,
    quartier_id,
    titre,
    description,
    adresse,
    type_bien,
    loyer,
    caution_mois,
    eau_courante,
    compteur_electrique,
    statut,
    verifie
)
VALUES (
    6,
    6,
    'Villa familiale à Mfilou',
    'Grande villa adaptée à une famille.',
    'Mfilou, Brazzaville',
    'villa',
    450000,
    3,
    TRUE,
    TRUE,
    'disponible',
    TRUE
);


-- ------------------------------------------------------------
-- Pointe-Noire - Tié-Tié
-- Disponible / Vérifié
-- ------------------------------------------------------------

INSERT INTO logement (
    user_id,
    quartier_id,
    titre,
    description,
    adresse,
    type_bien,
    loyer,
    caution_mois,
    eau_courante,
    compteur_electrique,
    statut,
    verifie
)
VALUES (
    1,
    7,
    'Appartement moderne à Tié-Tié',
    'Appartement situé dans une zone résidentielle.',
    'Tié-Tié, Pointe-Noire',
    'appartement',
    180000,
    2,
    TRUE,
    TRUE,
    'disponible',
    TRUE
);


-- ------------------------------------------------------------
-- Pointe-Noire - Loandjili
-- Disponible / Caution inconnue
-- ------------------------------------------------------------

INSERT INTO logement (
    user_id,
    quartier_id,
    titre,
    description,
    adresse,
    type_bien,
    loyer,
    caution_mois,
    eau_courante,
    compteur_electrique,
    statut,
    verifie
)
VALUES (
    2,
    8,
    'Maison à Loandjili',
    'Maison avec espace extérieur.',
    'Loandjili, Pointe-Noire',
    'maison',
    220000,
    NULL,
    TRUE,
    TRUE,
    'disponible',
    FALSE
);


-- ------------------------------------------------------------
-- Pointe-Noire - Lumumba
-- OCCUPÉ
-- ------------------------------------------------------------

INSERT INTO logement (
    user_id,
    quartier_id,
    titre,
    description,
    adresse,
    type_bien,
    loyer,
    caution_mois,
    eau_courante,
    compteur_electrique,
    statut,
    verifie
)
VALUES (
    3,
    9,
    'Studio à Lumumba',
    'Studio actuellement occupé.',
    'Lumumba, Pointe-Noire',
    'studio',
    100000,
    2,
    TRUE,
    TRUE,
    'occupe',
    TRUE
);


-- ------------------------------------------------------------
-- Pointe-Noire - Mongo-Mpoukou
-- Disponible / Vérifié
-- ------------------------------------------------------------

INSERT INTO logement (
    user_id,
    quartier_id,
    titre,
    description,
    adresse,
    type_bien,
    loyer,
    caution_mois,
    eau_courante,
    compteur_electrique,
    statut,
    verifie
)
VALUES (
    4,
    10,
    'Appartement à Mongo-Mpoukou',
    'Appartement avec accès à l eau courante.',
    'Mongo-Mpoukou, Pointe-Noire',
    'appartement',
    130000,
    2,
    TRUE,
    FALSE,
    'disponible',
    TRUE
);


-- ------------------------------------------------------------
-- Pointe-Noire - Mvoumvou
-- Disponible / Non vérifié
-- ------------------------------------------------------------

INSERT INTO logement (
    user_id,
    quartier_id,
    titre,
    description,
    adresse,
    type_bien,
    loyer,
    caution_mois,
    eau_courante,
    compteur_electrique,
    statut,
    verifie
)
VALUES (
    5,
    11,
    'Chambre à Mvoumvou',
    'Chambre simple dans une habitation résidentielle.',
    'Mvoumvou, Pointe-Noire',
    'chambre',
    60000,
    1,
    FALSE,
    TRUE,
    'disponible',
    FALSE
);


-- ------------------------------------------------------------
-- Pointe-Noire - Ngoyo
-- Disponible / Vérifié
-- ------------------------------------------------------------

INSERT INTO logement (
    user_id,
    quartier_id,
    titre,
    description,
    adresse,
    type_bien,
    loyer,
    caution_mois,
    eau_courante,
    compteur_electrique,
    statut,
    verifie
)
VALUES (
    6,
    12,
    'Villa à Ngoyo',
    'Villa spacieuse dans un secteur résidentiel.',
    'Ngoyo, Pointe-Noire',
    'villa',
    500000,
    3,
    TRUE,
    TRUE,
    'disponible',
    TRUE
);


-- ============================================================
-- 5. PHOTOS
-- ============================================================
-- Le logement "Studio à Bacongo" n'a volontairement aucune photo.

-- Appartement Moungali
INSERT INTO photo (logement_id, url, ordre)
VALUES
    (1, 'https://xbdrykfcqcicpewddvdg.supabase.co/storage/v1/object/sign/image/images1.jpg?token=eyJraWQiOiI3NDYyNzM5MC04MWIxLTRjZDgtOGJmYy1kNTc0YmNmNThjMWIiLCJhbGciOiJIUzUxMiJ9.eyJ1cmwiOiJpbWFnZS9pbWFnZXMxLmpwZyIsInNjb3BlIjoiZG93bmxvYWQiLCJpYXQiOjE3OTA4ODkyOTcsImV4cCI6MTc5MzQ4MTI5N30.WVQY8WJnOk088qAgpQM2kyMsvBs93slKabf5UL8xldmcPAVFnWAXBeSgwsnGB3h_YFKXpL7J7SrrdAfh4xzMfA', 1),
    (1, 'https://xbdrykfcqcicpewddvdg.supabase.co/storage/v1/object/sign/image/images%20(2).jpg?token=eyJraWQiOiI3NDYyNzM5MC04MWIxLTRjZDgtOGJmYy1kNTc0YmNmNThjMWIiLCJhbGciOiJIUzUxMiJ9.eyJ1cmwiOiJpbWFnZS9pbWFnZXMgKDIpLmpwZyIsInNjb3BlIjoiZG93bmxvYWQiLCJpYXQiOjE3OTA4ODkzMjgsImV4cCI6MTc5MzQ4MTMyOH0.m8U9F_7u8BKCT3oLl1d0e3rEjrEeLwVmSd4RqeXpFRh1GxH_lTXA-SyW1BalhRk3ZwTOUHTsje7wZNpI9ZwkHQ', 2);


-- Maison Talangaï
INSERT INTO photo (logement_id, url, ordre)
VALUES
    (3, '', 1);


-- Appartement Poto-Poto
INSERT INTO photo (logement_id, url, ordre)
VALUES
    (4, 'https://xbdrykfcqcicpewddvdg.supabase.co/storage/v1/object/sign/image/images%20(3).jpg?token=eyJraWQiOiI3NDYyNzM5MC04MWIxLTRjZDgtOGJmYy1kNTc0YmNmNThjMWIiLCJhbGciOiJIUzUxMiJ9.eyJ1cmwiOiJpbWFnZS9pbWFnZXMgKDMpLmpwZyIsInNjb3BlIjoiZG93bmxvYWQiLCJpYXQiOjE3OTA4ODkzNjgsImV4cCI6MTc5MzQ4MTM2OH0.FaA5Assq1y545CprWwaMAS_NGWgyYU8C7CQ71cs1grWc35nK2N9Cb0hAdPILokI8Gxo6K8TV8MANIqqHUCvdMg', 1);


-- Chambre Makélékélé
INSERT INTO photo (logement_id, url, ordre)
VALUES
    (5, '', 1);


-- Villa Mfilou
INSERT INTO photo (logement_id, url, ordre)
VALUES
    (6, '', 1),
    (6, '', 2);


-- Appartement Tié-Tié
INSERT INTO photo (logement_id, url, ordre)
VALUES
    (7, '', 1);


-- Maison Loandjili
INSERT INTO photo (logement_id, url, ordre)
VALUES
    (8, '', 1);


-- Studio Lumumba
INSERT INTO photo (logement_id, url, ordre)
VALUES
    (9, '', 1);


-- Appartement Mongo-Mpoukou
INSERT INTO photo (logement_id, url, ordre)
VALUES
    (10, '', 1);


-- Chambre Mvoumvou
INSERT INTO photo (logement_id, url, ordre)
VALUES
    (11, '', 1);


-- Villa Ngoyo
INSERT INTO photo (logement_id, url, ordre)
VALUES
    (12, '', 1),
    (12, '', 2);


