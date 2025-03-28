import crypto from "crypto";
import jwt from "jsonwebtoken";

export const generateSecurePassword = () =>
  crypto.randomBytes(8).toString("base64");

export const generateToken = (userId) => {
  return jwt.sign(
    { id: userId },
    process.env.JWT_SECRET || "your_jwt_secret_key",
    {
      expiresIn: process.env.JWT_EXPIRES_IN || "7d",
    }
  );
};
