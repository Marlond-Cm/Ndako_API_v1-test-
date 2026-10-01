const pool = require("../config/database");

const getAllLogements = async (filters = {}) => {
    const {
        villeId,
        quartierId,
        loyerMax,
        sort
    } = filters;

    const values = [];
    const conditions = [
        "l.statut = 'disponible'"
    ];

    if (villeId) {
        values.push(villeId);
        conditions.push(`v.id = $${values.length}`);
    }

    if (quartierId) {
        values.push(quartierId);
        conditions.push(`q.id = $${values.length}`);
    }

    if (loyerMax !== undefined && loyerMax !== null) {
        values.push(loyerMax);
        conditions.push(`l.loyer <= $${values.length}`);
    }

    let orderBy = "l.created_at DESC";

    if (sort === "loyer_asc") {
        orderBy = "l.loyer ASC";
    }

    const query = `
        SELECT
            l.id,
            l.titre,
            l.description,
            l.adresse,
            l.type_bien,
            l.loyer,
            l.caution_mois,
            l.eau_courante,
            l.compteur_electrique,
            l.statut,
            l.verifie,
            l.disponibilite_confirmee_at,

            q.id AS quartier_id,
            q.nom AS quartier,

            v.id AS ville_id,
            v.nom AS ville,

            COALESCE(
                (
                    SELECT json_agg(
                        json_build_object(
                            'id', p.id,
                            'url', p.url,
                            'ordre', p.ordre
                        )
                        ORDER BY p.ordre ASC
                    )
                    FROM photo p
                    WHERE p.logement_id = l.id
                ),
                '[]'::json
            ) AS photos

        FROM logement l

        INNER JOIN quartier q
            ON l.quartier_id = q.id

        INNER JOIN ville v
            ON q.ville_id = v.id

        WHERE ${conditions.join(" AND ")}

        ORDER BY ${orderBy}
    `;

    const result = await pool.query(query, values);

    return result.rows;
};

const getLogementById = async (id) => {
    const result = await pool.query(
        `
        SELECT
            l.id,
            l.titre,
            l.description,
            l.adresse,
            l.type_bien,
            l.loyer,
            l.caution_mois,
            l.eau_courante,
            l.compteur_electrique,
            l.statut,
            l.verifie,
            l.disponibilite_confirmee_at,
            l.created_at,
            l.updated_at,
            q.id AS quartier_id,
            q.nom AS quartier,
            v.id AS ville_id,
            v.nom AS ville,
            u.id AS utilisateur_id,
            u.nom AS proprietaire_nom,
            u.prenom AS proprietaire_prenom,
            u.telephone AS proprietaire_telephone
        FROM logement l
        INNER JOIN quartier q
            ON l.quartier_id = q.id
        INNER JOIN ville v
            ON q.ville_id = v.id
        INNER JOIN utilisateur u
            ON l.user_id = u.id
        WHERE l.id = $1
        `,
        [id]
    );

    return result.rows[0];
};

module.exports = {
    getAllLogements,
    getLogementById
};