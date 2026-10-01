const validate = (validationFunction) => {
    return (req, res, next) => {
        try {
            validationFunction(req);

            next();
        } catch (error) {
            next(error);
        }
    };
};

module.exports = validate;