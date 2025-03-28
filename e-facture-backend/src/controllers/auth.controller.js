import bcrypt from "bcrypt";
import User from "../models/user.model.js";

import {
  validateEmail,
  validateICE,
  validateLegalName,
  validateStrongPassword,
} from "../utils/validators.js";
import { generateSecurePassword, generateToken } from "../utils/helpers.js";
import {
  sendWelcomeEmail,
  sendResetPasswordEmail,
} from "../services/emailService.js";

// Fonction utilitaire pour vérifier existence d'utilisateur
const checkIfUserExists = async (email, ice, legalName) => {
  const existingUserByLegalName = await User.findOne({ legalName });
  if (existingUserByLegalName)
    return "Un utilisateur avec cette raison sociale existe déjà";
  const existingUserByIce = await User.findOne({ ice });
  if (existingUserByIce) return "Un utilisateur avec cet ICE existe déjà";
  const existingUserByEmail = await User.findOne({ email });
  if (existingUserByEmail) return "Un utilisateur avec cet email existe déjà";
  return null;
};

// Register
export const register = async (req, res) => {
  const { email, ice, legalName } = req.body;

  if (!email || !ice || !legalName)
    return res
      .status(400)
      .json({ success: false, message: "Tous les champs sont obligatoires" });
  if (!validateLegalName(legalName))
    return res.status(400).json({
      success: false,
      message: "La raison sociale doit avoir entre 3 et 100 caractères",
    });
  if (!validateICE(ice))
    return res.status(400).json({
      success: false,
      message: "L'ICE doit être numérique et avoir entre 8 et 15 chiffres",
    });
  if (!validateEmail(email))
    return res
      .status(400)
      .json({ success: false, message: "Format d'email invalide" });

  const errorMessage = await checkIfUserExists(email, ice, legalName);
  if (errorMessage)
    return res.status(400).json({ success: false, message: errorMessage });

  const tempPassword = generateSecurePassword();
  const salt = await bcrypt.genSalt(10);
  const hashedPassword = await bcrypt.hash(tempPassword, salt);

  const newUser = new User({ email, ice, legalName, password: hashedPassword });
  await newUser.save();

  sendWelcomeEmail(email, tempPassword, legalName);

  res.status(201).json({
    success: true,
    message: "Utilisateur inscrit avec succès. Veuillez vous connecter.",
  });
};

// Login
export const login = async (req, res) => {
  const { email, password } = req.body;

  if (!email || !password)
    return res
      .status(400)
      .json({ success: false, message: "Ce champ ne peut pas être vide." });
  if (!validateEmail(email))
    return res
      .status(400)
      .json({ success: false, message: "Veuillez entrer un email valide." });

  const user = await User.findOne({ email });
  if (!user)
    return res
      .status(401)
      .json({ success: false, message: "Email ou mot de passe incorrect." });
  if (!user.isActive)
    return res
      .status(401)
      .json({ success: false, message: "Ce compte a été désactivé." });

  const isPasswordValid = await bcrypt.compare(password, user.password);
  if (!isPasswordValid)
    return res
      .status(401)
      .json({ success: false, message: "Email ou mot de passe incorrect." });

  const token = generateToken(user._id);

  const userData = {
    id: user._id,
    email: user.email,
    legalName: user.legalName,
    ice: user.ice,
    isAdmin: user.isAdmin,
    isFirstLogin: user.isFirstLogin,
  };

  res.status(200).json({
    success: true,
    message: "Connexion réussie",
    user: userData,
    token: token,
  });
};

// Change Password
export const changePassword = async (req, res) => {
  const { currentPassword, newPassword } = req.body;
  const user = req.user;

  if (!currentPassword || !newPassword) {
    return res.status(400).json({
      success: false,
      message: "Ce champ ne peut pas être vide.",
    });
  }

  // Vérifier mot de passe actuel
  const isPasswordValid = await bcrypt.compare(currentPassword, user.password);
  if (!isPasswordValid) {
    return res.status(401).json({
      success: false,
      message: "Mot de passe actuel incorrect.",
    });
  }

  // Vérifier que le nouveau mot de passe est fort
  if (!validateStrongPassword(newPassword)) {
    return res.status(400).json({
      success: false,
      message:
        "Le mot de passe est trop faible. Il doit contenir au moins 8 caractères, une majuscule, une minuscule et un chiffre.",
    });
  }

  // Vérifier si le nouveau mot de passe est différent de l'ancien
  const isSamePassword = await bcrypt.compare(newPassword, user.password);
  if (isSamePassword) {
    return res.status(400).json({
      success: false,
      message: "Le nouveau mot de passe ne peut pas être identique à l'ancien.",
    });
  }

  // Hasher et enregistrer
  const salt = await bcrypt.genSalt(10);
  const hashedPassword = await bcrypt.hash(newPassword, salt);

  user.password = hashedPassword;
  user.isFirstLogin = false;
  await user.save();

  return res.status(200).json({
    success: true,
    message: "Mot de passe modifié avec succès.",
  });
};

// Forgot Password
export const forgotPassword = async (req, res) => {
  const { email, ice, legalName } = req.body;

  if (!email || !ice || !legalName)
    return res.status(400).json({
      success: false,
      message: "Tous les champs sont obligatoires.",
    });

  if (
    !validateEmail(email) ||
    !validateICE(ice) ||
    !validateLegalName(legalName)
  ) {
    return res.status(400).json({
      success: false,
      message: "Les informations fournies ne sont pas valides.",
    });
  }

  const user = await User.findOne({ email, ice, legalName });

  // On ne révèle pas si l'utilisateur existe ou pas
  if (!user) {
    return res.status(200).json({
      success: true,
      message:
        "Si les informations fournies sont correctes, un mot de passe temporaire vous a été envoyé par email.",
    });
  }

  const tempPassword = generateSecurePassword();
  const salt = await bcrypt.genSalt(10);
  const hashedPassword = await bcrypt.hash(tempPassword, salt);

  user.password = hashedPassword;
  user.isFirstLogin = true;
  await user.save();

  // Envoi du mail personnalisé
  sendResetPasswordEmail(email, tempPassword, legalName);

  return res.status(200).json({
    success: true,
    message:
      "Si les informations fournies sont correctes, un mot de passe temporaire vous a été envoyé par email.",
  });
};

// Profile
export const getProfile = async (req, res) => {
  res.status(200).json({
    success: true,
    user: {
      id: req.user._id,
      email: req.user.email,
      legalName: req.user.legalName,
      ice: req.user.ice,
      isAdmin: req.user.isAdmin,
    },
  });
};
