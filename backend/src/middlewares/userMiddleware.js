const Joi = require("joi");

const validateUser = (req, res, next) => {
  const { error } = Joi.object({
    email: Joi.string().max(255).presence("required"),
    password: Joi.string().max(30).presence("required"),
    lastname: Joi.string().max(80).presence("required"),
    firstname: Joi.string().max(80).presence("required"),
    emailpro: Joi.string().max(255).presence("optional"),
    phone: Joi.string().max(37).presence("optional"),
    profession_id: Joi.number().max(30).presence("required"),
    employeur: Joi.string().max(255).presence("optional"),
    poste: Joi.string().max(255).presence("optional"),
    bio: Joi.string().max(1000).presence("optional"),
    siteweb: Joi.string().max(255).presence("optional"),
    facebook: Joi.string().max(255).presence("optional"),
    linkedin: Joi.string().max(255).presence("optional"),
    twitter: Joi.string().max(255).presence("optional"),
    instagram: Joi.string().max(255).presence("optional"),
  }).validate(req.body, { abortEarly: false });

  if (!error) {
    next();
  } else {
    res.status(400).json(error);
  }
};

module.exports = { validateUser };
