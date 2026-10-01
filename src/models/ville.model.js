const pool = require("../config/database");

const getAllVilles = async () => {
    const result = await pool.query(`
        SELECT id, nom
        FROM ville
        ORDER BY nom ASC
    `);

    return result.rows;
};

const getVilleById = async (id) => {
    const result = await pool.query(
        `
        SELECT id, nom
        FROM ville
        WHERE id = $1
        `,
        [id]
    );

    return result.rows[0];
};

module.exports = {
    getAllVilles,
    getVilleById
};