const quartierModel = require("../models/quartier.model");

const getQuartiersByVille = async (req, res, next) => {
    try {
        const { villeId } = req.params;

        const quartiers = await quartierModel.getQuartiersByVilleId(villeId);

        res.status(200).json({
            success: true,
            data: quartiers
        });
    } catch (error) {
        next(error);
    }
};

module.exports = {
    getQuartiersByVille
};