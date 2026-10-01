const express = require("express");

const villeRoutes = require("./ville.routes");
const quartierRoutes = require("./quartier.routes");
const logementRoutes = require("./logement.routes");
const photoRoutes = require("./photo.routes");

const router = express.Router();

router.use("/villes", villeRoutes);
router.use("/", quartierRoutes);
router.use("/logements", logementRoutes);
router.use("/", photoRoutes);

module.exports = router;