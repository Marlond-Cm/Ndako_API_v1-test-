const express = require("express");

const photoController = require("../controllers/photo.controller");

const router = express.Router();

router.get(
    "/logements/:logementId/photos",
    photoController.getPhotosByLogement
);

module.exports = router;