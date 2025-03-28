import express from "express";
import auth from "../middlewares/auth.middleware.js";
import {
  register,
  login,
  changePassword,
  forgotPassword,
  getProfile,
} from "../controllers/auth.controller.js";

const router = express.Router();

router.post("/register", register);
router.post("/login", login);
router.post("/change-password", auth, changePassword);
router.post("/forgot-password", forgotPassword);
router.get("/profile", auth, getProfile);

export default router;
