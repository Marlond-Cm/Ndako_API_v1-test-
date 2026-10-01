const express = require("express");
const villeController = require("../controllers/ville.controller");

const router = express.Router();

router.get("/", villeController.getVilles);

module.exports = router;