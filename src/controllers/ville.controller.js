const villeModel = require("../models/ville.model");

const getVilles = async (req, res, next) => {
    try {
        const villes = await villeModel.getAllVilles();

        res.status(200).json({
            success: true,
            data: villes
        });
    } catch (error) {
        next(error);
    }
};

module.exports = {
    getVilles
};