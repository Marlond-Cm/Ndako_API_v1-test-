# NDAKO TECH — API Backend

API REST développée pour la plateforme **NDAKO TECH**, une solution de recherche de logements.

Cette API permet principalement de consulter les villes, les quartiers et les logements disponibles, avec leurs informations, photos et caractéristiques.

## Technologies utilisées

* Node.js
* Express.js
* PostgreSQL
* `pg` — connexion à PostgreSQL
* Helmet — sécurité HTTP
* CORS — gestion des accès cross-origin
* Morgan — journalisation des requêtes HTTP
* Express Rate Limit — limitation du nombre de requêtes

## Structure principale

```text
Ndako_API/
├── database/
├── src/
│   ├── config/
│   ├── controllers/
│   ├── middlewares/
│   ├── models/
│   ├── routes/
│   ├── app.js
│   └── server.js
├── .env.example
├── .gitignore
├── package.json
├── package-lock.json
├── app.js
└── server.js
```

## Fonctionnalités développées

L'API permet actuellement de :

* récupérer la liste des villes ;
* récupérer les quartiers d'une ville ;
* rechercher les logements disponibles ;
* filtrer les logements par ville ;
* filtrer les logements par quartier ;
* filtrer les logements selon un loyer maximum ;
* trier les logements par loyer croissant ;
* consulter les détails d'un logement ;
* récupérer les photos d'un logement ;
* afficher les informations du propriétaire associées au logement ;
* gérer les erreurs HTTP avec des réponses JSON standardisées ;
* journaliser les requêtes HTTP ;
* limiter les requêtes vers l'API.

---

# API

## URL de base

```text
http://localhost:5000
```

Version actuelle :

```text
/api/v1
```

---

# Routes

## 1. Vérifier l'état de l'API

### GET

```http
GET /api/health
```

### Réponse

```json
{
  "success": true,
  "data": {
    "status": "ok",
    "message": "API NDAKO TECH opérationnelle"
  }
}
```

---

## 2. Récupérer les villes

### GET

```http
GET /api/v1/villes
```

### Réponse

```json
{
  "success": true,
  "data": [
    {
      "id": 1,
      "nom": "Brazzaville"
    },
    {
      "id": 2,
      "nom": "Pointe-Noire"
    }
  ]
}
```

---

## 3. Récupérer les quartiers d'une ville

### GET

```http
GET /api/v1/villes/:villeId/quartiers
```

### Exemple

```http
GET /api/v1/villes/1/quartiers
```

### Réponse

```json
{
  "success": true,
  "data": [
    {
      "id": 1,
      "nom": "Bacongo",
      "ville_id": 1
    },
    {
      "id": 2,
      "nom": "Moungali",
      "ville_id": 1
    }
  ]
}
```

---

# Logements

## 4. Récupérer les logements disponibles

### GET

```http
GET /api/v1/logements
```

Cette route retourne uniquement les logements ayant le statut :

```text
disponible
```

### Réponse

```json
{
  "success": true,
  "data": [
    {
      "id": 1,
      "titre": "Appartement moderne",
      "description": "Appartement confortable...",
      "adresse": "123 rue Exemple",
      "type_bien": "appartement",
      "loyer": 150000,
      "caution_mois": 2,
      "eau_courante": true,
      "compteur_electrique": true,
      "statut": "disponible",
      "verifie": true,
      "disponibilite_confirmee_at": "2026-09-20T10:30:00.000Z",
      "quartier_id": 1,
      "quartier": "Bacongo",
      "ville_id": 1,
      "ville": "Brazzaville",
      "photos": [
        {
          "id": 1,
          "url": "https://example.com/photo1.jpg",
          "ordre": 1
        }
      ]
    }
  ]
}
```

---

## 5. Filtrer par ville

### GET

```http
GET /api/v1/logements?ville_id=1
```

Retourne les logements disponibles appartenant à la ville sélectionnée.

---

## 6. Filtrer par quartier

### GET

```http
GET /api/v1/logements?quartier_id=3
```

Retourne les logements disponibles du quartier sélectionné.

---

## 7. Filtrer par loyer maximum

### GET

```http
GET /api/v1/logements?loyer_max=150000
```

Retourne les logements dont le loyer est inférieur ou égal à `150000 FCFA`.

---

## 8. Combiner plusieurs filtres

### GET

```http
GET /api/v1/logements?ville_id=1&quartier_id=3&loyer_max=150000
```

Les différents critères sont appliqués simultanément.

---

## 9. Trier par loyer croissant

### GET

```http
GET /api/v1/logements?sort=loyer_asc
```

Les logements sont classés du loyer le moins élevé au plus élevé.

Les filtres peuvent également être combinés :

```http
GET /api/v1/logements?ville_id=1&loyer_max=150000&sort=loyer_asc
```

---

# Détails d'un logement

## 10. Récupérer un logement

### GET

```http
GET /api/v1/logements/:id
```

### Exemple

```http
GET /api/v1/logements/1
```

### Réponse Exemple 

```json
{
  "success": true,
  "data": {
    "id": 1,
    "titre": "Appartement moderne",
    "description": "Appartement confortable...",
    "adresse": "123 rue Exemple",
    "type_bien": "appartement",
    "loyer": 150000,
    "caution_mois": 2,
    "eau_courante": true,
    "compteur_electrique": true,
    "statut": "disponible",
    "verifie": true,
    "disponibilite_confirmee_at": "2026-09-20T10:30:00.000Z",
    "quartier_id": 1,
    "quartier": "Bacongo",
    "ville_id": 1,
    "ville": "Brazzaville",
    "utilisateur_id": 1,
    "proprietaire_nom": "MABIALA",
    "proprietaire_prenom": "Jean",
    "proprietaire_telephone": "+242060000000",
    "photos": [
      {
        "id": 1,
        "url": "https://example.com/photo1.jpg",
        "ordre": 1
      }
    ]
  }
}
```

---

# Photos d'un logement

## 11. Récupérer les photos

### GET

```http
GET /api/v1/logements/:logementId/photos
```

### Exemple

```http
GET /api/v1/logements/1/photos
```

### Réponse Exemple

```json
{
  "success": true,
  "data": [
    {
      "id": 1,
      "url": "https://example.com/photo1.jpg",
      "ordre": 1
    },
    {
      "id": 2,
      "url": "https://example.com/photo2.jpg",
      "ordre": 2
    }
  ]
}
```

Si le logement ne possède aucune photo :

```json
{
  "success": true,
  "data": []
}
```

---

# Gestion des erreurs

L'API utilise une structure JSON commune pour les erreurs.

### Exemple : logement inexistant

```http
GET /api/v1/logements/99999
```

### Réponse

```json
{
  "success": false,
  "error": {
    "code": "LOGEMENT_NOT_FOUND",
    "message": "Le logement demandé n'existe pas."
  }
}
```

### Exemple : paramètre invalide

```http
GET /api/v1/logements?loyer_max=abc
```

### Réponse

```json
{
  "success": false,
  "error": {
    "code": "INVALID_LOYER_MAX",
    "message": "Le paramètre loyer_max doit être un nombre supérieur ou égal à 0."
  }
}
```

---

# Installation

Cloner le projet puis installer les dépendances :

```bash
npm install
```

Créer le fichier `.env` à partir de `.env.example`.

Exemple :

```env
PORT=5000

DB_HOST=localhost
DB_PORT=5432
DB_NAME=ndako_db
DB_USER=postgres
DB_PASSWORD=votre_mot_de_passe
```

Lancer le serveur :

```bash
node src/server.js
```

L'API sera disponible sur :

```text
http://localhost:5000
```

---

# Statut du projet

**Version : V1 — API de consultation**

Les fonctionnalités actuelles sont principalement orientées vers la consultation et la recherche de logements.

Les fonctionnalités telles que l'authentification, la publication réelle de logements, les paiements, les réservations, les notifications et la messagerie ne font pas partie de cette version.
