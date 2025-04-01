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

import { hashPassword, comparePasswords } from "../utils/password.js";
import { successResponse, errorResponse } from "../utils/responses.js";
import { checkUserConflicts, formatUserForClient } from "../utils/userUtils.js";

// Register
export const register = async (req, res) => {
  try {
    const email = req.body.email?.trim().toLowerCase();
    const { ice, legalName } = req.body;

    if (!email || !ice || !legalName) {
      return errorResponse(res, "errorsMissingFields");
    }

    if (!validateLegalName(legalName)) {
      return errorResponse(res, "errorsInvalidLegalName");
    }

    if (!validateICE(ice)) {
      return errorResponse(res, "errorsInvalidIce");
    }

    if (!validateEmail(email)) {
      return errorResponse(res, "errorsInvalidEmail");
    }

    const conflicts = await checkUserConflicts({ email, ice, legalName });
    const conflictCode = Object.values(conflicts)[0];
    if (conflictCode) {
      return errorResponse(res, conflictCode, 409);
    }

    const tempPassword = generateSecurePassword();
    const hashedPassword = await hashPassword(tempPassword);

    const newUser = new User({
      email,
      ice,
      legalName,
      password: hashedPassword,
    });

    await newUser.save();
    sendWelcomeEmail(email, tempPassword, legalName);

    return successResponse(res, "registrationSuccess");
  } catch (error) {
    console.error("Register error:", error);
    return errorResponse(res, "errorsInternal", 500);
  }
};

// Login
export const login = async (req, res) => {
  try {
    const email = req.body.email?.trim().toLowerCase();
    const { password } = req.body;

    if (!email || !password) {
      return errorResponse(res, "errorsMissingFields");
    }

    if (!validateEmail(email)) {
      return errorResponse(res, "errorsInvalidEmail");
    }

    const user = await User.findOne({ email });
    if (!user) {
      return errorResponse(res, "errorsInvalidCredentials", 401);
    }

    if (!user.isActive) {
      return errorResponse(res, "errorsUserDisabled", 403);
    }

    const isPasswordValid = await comparePasswords(password, user.password);
    if (!isPasswordValid) {
      return errorResponse(res, "errorsInvalidCredentials", 401);
    }

    const token = generateToken(user._id);
    const userData = formatUserForClient(user);

    return successResponse(res, "loginSuccess", {
      user: userData,
      token,
    });
  } catch (error) {
    console.error("Login error:", error);
    return errorResponse(res, "errorsInternal", 500);
  }
};

// Change Password
export const changePassword = async (req, res) => {
  const { currentPassword, newPassword } = req.body;
  const user = req.user;

  if (!currentPassword || !newPassword) {
    return errorResponse(res, "errorsMissingFields");
  }

  const isPasswordValid = await comparePasswords(
    currentPassword,
    user.password
  );
  if (!isPasswordValid) {
    return errorResponse(res, "errorsInvalidCurrentPassword", 401);
  }

  if (!validateStrongPassword(newPassword)) {
    return errorResponse(res, "errorsWeakPassword");
  }

  const isSamePassword = await comparePasswords(newPassword, user.password);
  if (isSamePassword) {
    return errorResponse(res, "errorsSamePassword");
  }

  user.password = await hashPassword(newPassword);
  user.isFirstLogin = false;
  await user.save();

  return successResponse(res, "passwordChangedSuccess");
};

// Forgot Password
export const forgotPassword = async (req, res) => {
  const email = req.body.email?.trim().toLowerCase();
  const { ice, legalName } = req.body;

  if (!email || !ice || !legalName) {
    return errorResponse(res, "errorsMissingFields");
  }

  if (
    !validateEmail(email) ||
    !validateICE(ice) ||
    !validateLegalName(legalName)
  ) {
    return errorResponse(res, "errorsInvalidUserInfo");
  }

  const user = await User.findOne({ email, ice, legalName });

  if (!user) {
    // Return generic success even if user not found
    return successResponse(res, "resetEmailSent");
  }

  const tempPassword = generateSecurePassword();
  user.password = await hashPassword(tempPassword);
  user.isFirstLogin = true;
  await user.save();

  sendResetPasswordEmail(email, tempPassword, legalName);

  return successResponse(res, "resetEmailSent");
};

// Get Profile
export const getProfile = async (req, res) => {
  const userData = formatUserForClient(req.user);
  return successResponse(res, "profileRetrieved", { user: userData });
};
