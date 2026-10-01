const photoModel = require("../models/photo.model");

const getPhotosByLogement = async (req, res, next) => {
    try {
        const { logementId } = req.params;

        const photos = await photoModel.getPhotosByLogementId(logementId);

        res.status(200).json({
            success: true,
            data: photos
        });
    } catch (error) {
        next(error);
    }
};

module.exports = {
    getPhotosByLogement
};