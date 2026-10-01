const errorMiddleware = (error, req, res, next) => {
    console.error("Erreur :", error);

    const statusCode = error.statusCode || 500;

    res.status(statusCode).json({
        success: false,
        error: {
            code: error.code || "INTERNAL_SERVER_ERROR",
            message: error.message || "Une erreur interne est survenue."
        }
    });
};

module.exports = errorMiddleware;