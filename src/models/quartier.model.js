const pool = require("../config/database");

const getQuartiersByVilleId = async (villeId) => {
    const result = await pool.query(
        `
        SELECT id, nom, ville_id
        FROM quartier
        WHERE ville_id = $1
        ORDER BY nom ASC
        `,
        [villeId]
    );

    return result.rows;
};

module.exports = {
    getQuartiersByVilleId
};