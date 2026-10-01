const express = require("express");
const cors = require("cors");
const helmet = require("helmet");
const morgan = require("morgan");

const routes = require("./src/routes");
const notFoundMiddleware = require("./src/middlewares/not-found.middleware");
const errorMiddleware = require("./src/middlewares/error.middleware");

const app = express();
// ==============================
// logger HTTP
// ==============================
app.use(morgan("dev"));

// ==============================
// MIDDLEWARES DE SÉCURITÉ
// ==============================

app.use(helmet());

app.use(cors());

// ==============================
// MIDDLEWARES DE PARSING
// ==============================

app.use(express.json({ limit: "10kb" }));

// ==============================
// ROUTE DE SANTÉ
// ==============================

app.get("/api/health", (req, res) => {
    res.status(200).json({
        success: true,
        data: {
            status: "ok",
            message: "API NDAKO TECH opérationnelle"
        }
    });
});

// ==============================
// ROUTES API V1
// ==============================

app.use("/api/v1", routes);

// ==============================
// ROUTE NON TROUVÉE
// ==============================

app.use(notFoundMiddleware);

// ==============================
// GESTION DES ERREURS
// ==============================

app.use(errorMiddleware);

module.exports = app;