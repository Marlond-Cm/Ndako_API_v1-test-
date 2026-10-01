const pool = require("../config/database");

const getUtilisateurById = async (id) => {
    const result = await pool.query(
        `
        SELECT id, nom, prenom, telephone, statut
        FROM utilisateur
        WHERE id = $1
        `,
        [id]
    );

    return result.rows[0];
};

module.exports = {
    getUtilisateurById
};