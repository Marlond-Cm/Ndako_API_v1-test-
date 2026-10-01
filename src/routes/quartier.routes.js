const express = require("express");
const quartierController = require("../controllers/quartier.controller");

const router = express.Router();

router.get(
    "/villes/:villeId/quartiers",
    quartierController.getQuartiersByVille
);

module.exports = router;