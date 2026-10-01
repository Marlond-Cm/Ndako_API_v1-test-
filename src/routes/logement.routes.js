const express = require("express");

const logementController = require("../controllers/logement.controller");
const validate = require("../middlewares/validate.middleware");

const router = express.Router();

const validateLogementQuery = (req) => {
    const {
        ville_id,
        quartier_id,
        loyer_max,
        sort
    } = req.query;

    if (ville_id !== undefined) {
        const villeId = Number(ville_id);

        if (!Number.isInteger(villeId) || villeId <= 0) {
            const error = new Error(
                "Le paramètre ville_id doit être un entier positif."
            );

            error.statusCode = 400;
            error.code = "INVALID_VILLE_ID";

            throw error;
        }

        req.query.ville_id = villeId;
    }

    if (quartier_id !== undefined) {
        const quartierId = Number(quartier_id);

        if (!Number.isInteger(quartierId) || quartierId <= 0) {
            const error = new Error(
                "Le paramètre quartier_id doit être un entier positif."
            );

            error.statusCode = 400;
            error.code = "INVALID_QUARTIER_ID";

            throw error;
        }

        req.query.quartier_id = quartierId;
    }

    if (loyer_max !== undefined) {
        const loyerMax = Number(loyer_max);

        if (!Number.isFinite(loyerMax) || loyerMax < 0) {
            const error = new Error(
                "Le paramètre loyer_max doit être un nombre supérieur ou égal à 0."
            );

            error.statusCode = 400;
            error.code = "INVALID_LOYER_MAX";

            throw error;
        }

        req.query.loyer_max = loyerMax;
    }

    if (sort !== undefined && sort !== "loyer_asc") {
        const error = new Error(
            "Le paramètre sort doit être égal à loyer_asc."
        );

        error.statusCode = 400;
        error.code = "INVALID_SORT";

        throw error;
    }
};

router.get(
    "/",
    validate(validateLogementQuery),
    logementController.getLogements
);

router.get("/:id", logementController.getLogementById);

module.exports = router;