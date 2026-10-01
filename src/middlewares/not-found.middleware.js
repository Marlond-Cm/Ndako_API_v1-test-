const notFoundMiddleware = (req, res) => {
    res.status(404).json({
        success: false,
        error: {
            code: "ROUTE_NOT_FOUND",
            message: `La route ${req.method} ${req.originalUrl} n'existe pas.`
        }
    });
};

module.exports = notFoundMiddleware;