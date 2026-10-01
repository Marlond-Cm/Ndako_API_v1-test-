-- ============================================================
-- NDAKO TECH
-- Schéma PostgreSQL - Gestion des logements
-- Version 1.0
-- ============================================================

-- ============================================================
-- 1. TYPES ENUMERES
-- ============================================================

CREATE TYPE type_bien AS ENUM (
    'appartement',
    'maison',
    'studio',
    'chambre',
    'villa',
    'autre'
);

CREATE TYPE statut_logement AS ENUM (
    'disponible',
    'occupe'
);


-- ============================================================
-- 2. TABLE UTILISATEUR
-- ============================================================

CREATE TABLE utilisateur (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    nom VARCHAR(100) NOT NULL,

    prenom VARCHAR(100) NOT NULL,

    telephone VARCHAR(20) NOT NULL UNIQUE,

    statut VARCHAR(20) NOT NULL DEFAULT 'actif'
);


-- ============================================================
-- 3. TABLE VILLE
-- ============================================================

CREATE TABLE ville (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    nom VARCHAR(100) NOT NULL UNIQUE
);


-- ============================================================
-- 4. TABLE QUARTIER
-- ============================================================

CREATE TABLE quartier (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    ville_id INTEGER NOT NULL
        REFERENCES ville(id)
        ON DELETE RESTRICT,

    nom VARCHAR(100) NOT NULL,

    UNIQUE (ville_id, nom)
);


-- ============================================================
-- 5. TABLE LOGEMENT
-- ============================================================

CREATE TABLE logement (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    user_id INTEGER NOT NULL
        REFERENCES utilisateur(id)
        ON DELETE CASCADE,

    quartier_id INTEGER NOT NULL
        REFERENCES quartier(id)
        ON DELETE RESTRICT,

    titre VARCHAR(200) NOT NULL,

    description TEXT,

    adresse VARCHAR(255),

    type_bien type_bien NOT NULL DEFAULT 'autre',

    loyer DECIMAL(12,2) NOT NULL
        CHECK (loyer >= 0),

    /*
     * Nombre de mois de caution.
     *
     * NULL = caution à confirmer
     * 0    = aucune caution
     * 1    = une caution d'un mois
     * 2    = deux mois, etc.
     */
    caution_mois INTEGER
        CHECK (caution_mois >= 0),

    eau_courante BOOLEAN NOT NULL DEFAULT FALSE,

    compteur_electrique BOOLEAN NOT NULL DEFAULT FALSE,

    statut statut_logement NOT NULL DEFAULT 'disponible',

    verifie BOOLEAN NOT NULL DEFAULT FALSE,

    /*
     * Date métier :
     * dernière fois où la disponibilité du logement
     * a été confirmée ou modifiée.
     *
     * Cette date ne change PAS lorsqu'un simple détail
     * du logement est modifié.
     */
    disponibilite_confirmee_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    /*
     * Date technique de création de l'enregistrement.
     */
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    /*
     * Date technique de dernière modification
     * de l'enregistrement.
     */
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


-- ============================================================
-- 6. TABLE PHOTO
-- ============================================================

CREATE TABLE photo (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    logement_id INTEGER NOT NULL
        REFERENCES logement(id)
        ON DELETE CASCADE,

    url TEXT NOT NULL,

    ordre INTEGER NOT NULL DEFAULT 0,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    UNIQUE (logement_id, ordre)
);


-- ============================================================
-- 7. INDEX
-- ============================================================

-- Recherche des logements par utilisateur
CREATE INDEX idx_logement_user
    ON logement(user_id);


-- Recherche par quartier et statut
CREATE INDEX idx_logement_quartier_statut
    ON logement(quartier_id, statut);


-- Recherche par loyer
CREATE INDEX idx_logement_loyer
    ON logement(loyer);


-- Recherche combinée
CREATE INDEX idx_logement_recherche
    ON logement(quartier_id, statut, loyer);


-- Photos d'un logement
CREATE INDEX idx_photo_logement
    ON photo(logement_id);


-- ============================================================
-- 8. TRIGGER updated_at
-- ============================================================

CREATE OR REPLACE FUNCTION set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_logement_updated_at
BEFORE UPDATE ON logement
FOR EACH ROW
EXECUTE FUNCTION set_updated_at();


-- ============================================================
-- 9. TRIGGER disponibilite_confirmee_at
-- ============================================================

/*
 * La date de disponibilité est mise à jour UNIQUEMENT
 * lorsque le statut du logement change.
 *
 * Exemple :
 *
 * disponible -> occupe
 * occupe     -> disponible
 *
 * En revanche :
 *
 * modification du titre
 * modification de la description
 * modification du loyer
 * modification d'une adresse
 *
 * ne modifient PAS cette date.
 */

CREATE OR REPLACE FUNCTION update_disponibilite_confirmee_at()
RETURNS TRIGGER AS $$
BEGIN

    IF OLD.statut IS DISTINCT FROM NEW.statut THEN
        NEW.disponibilite_confirmee_at = CURRENT_TIMESTAMP;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_logement_disponibilite
BEFORE UPDATE ON logement
FOR EACH ROW
EXECUTE FUNCTION update_disponibilite_confirmee_at();


