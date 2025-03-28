import express from "express";
import auth from "../middlewares/auth.middleware.js";
import {
  getAllUsers,
  toggleUserActivation,
  getInvoicesForAdmin,
  searchUsers,
  downloadInvoiceForAdmin,
  getWeeklyInvoiceStats,
  getMonthlyInvoiceStats,
  getUserStatusStats,
  getPlatformAdoptionStats,
  getAdminDashboardStats,
} from "../controllers/admin.controller.js";

const router = express.Router();

// Route pour récupérer les users (admin uniquement)
router.get("/users", auth, getAllUsers);
router.put("/users/:id/disable", auth, toggleUserActivation);

// Toutes les factures (globales ou filtrées)
router.get("/invoices", auth, getInvoicesForAdmin);

// Route pour récupérer les factures d'un utilisateur spécifique
router.get("/users/:userId/invoices", auth, getInvoicesForAdmin); // Ajout de la route spécifique

// Recherche des utilisateurs par email, ICE, legalName
router.get("/users/search", auth, searchUsers);

router.get("/invoices/:invoiceId/download", auth, downloadInvoiceForAdmin);
router.get("/invoices/weekly-stats", auth, getWeeklyInvoiceStats);
router.get("/invoices/monthly-stats", auth, getMonthlyInvoiceStats);
router.get("/users/status-stats", auth, getUserStatusStats);
router.get("/users/adoption-stats", auth, getPlatformAdoptionStats);
router.get("/dashboard-stats", auth, getAdminDashboardStats);

export default router;
