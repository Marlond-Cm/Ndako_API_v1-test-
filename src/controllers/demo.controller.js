const getDemo = async (req, res) => {
    res.status(200).json({
        success: true,
        data: {
            message: "API NDAKO TECH opérationnelle",
            environnement: process.env.NODE_ENV || "development"
        }
    });
};

module.exports = {
    getDemo
};