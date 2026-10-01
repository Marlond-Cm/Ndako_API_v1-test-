const logementModel = require("../models/logement.model");
const photoModel = require("../models/photo.model");

const getLogements = async (req, res, next) => {
    try {
        const {
            ville_id,
            quartier_id,
            loyer_max,
            sort
        } = req.query;

        const logements = await logementModel.getAllLogements({
            villeId: ville_id,
            quartierId: quartier_id,
            loyerMax: loyer_max,
            sort
        });

        res.status(200).json({
            success: true,
            data: logements
        });
    } catch (error) {
        next(error);
    }
};

const getLogementById = async (req, res, next) => {
    try {
        const { id } = req.params;

        const logement = await logementModel.getLogementById(id);

        if (!logement) {
            return res.status(404).json({
                success: false,
                error: {
                    code: "LOGEMENT_NOT_FOUND",
                    message: "Le logement demandé n'existe pas."
                }
            });
        }

        const photos = await photoModel.getPhotosByLogementId(id);

        res.status(200).json({
            success: true,
            data: {
                ...logement,
                photos
            }
        });
    } catch (error) {
        next(error);
    }
};

module.exports = {
    getLogements,
    getLogementById
};