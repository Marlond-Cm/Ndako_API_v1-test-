const pool = require("../config/database");

const getPhotosByLogementId = async (logementId) => {
    const result = await pool.query(
        `
        SELECT id, url, ordre
        FROM photo
        WHERE logement_id = $1
        ORDER BY ordre ASC
        `,
        [logementId]
    );

    return result.rows;
};

module.exports = {
    getPhotosByLogementId
};