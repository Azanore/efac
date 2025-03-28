import express from "express";
import multer from "multer";
import auth from "../middlewares/auth.middleware.js";
import {
  createInvoice,
  getInvoicesByUser,
  downloadInvoice,
  getStats,
  getUserInvoicesWithDateFilter,
} from "../controllers/invoice.controller.js";

const router = express.Router();

// Multer config
const storage = multer.memoryStorage();
const upload = multer({
  storage: storage,
  limits: { fileSize: 2 * 1024 * 1024 },
});

// ✅ ROUTES fixes d'abord !
router.get("/stats", auth, getStats);

// ✅ Route pour filtrer par date
router.get("/", auth, getUserInvoicesWithDateFilter);

// Créer une facture
router.post("/", auth, upload.single("file"), createInvoice);

// Télécharger une facture
router.get("/:invoiceId/download", auth, downloadInvoice);

// ✅ Route dynamique TOUT EN BAS
router.get("/:userId", auth, getInvoicesByUser);

export default router;
