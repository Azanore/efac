import User from "../models/user.model.js";
import Invoice from "../models/invoice.model.js";
import mongoose from "mongoose"; // Si besoin pour ObjectId
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";

export const toggleUserActivation = async (req, res) => {
  try {
    if (!req.user.isAdmin) {
      return res.status(403).json({
        success: false,
        message: "Accès refusé. Réservé aux administrateurs.",
      });
    }

    const { id } = req.params;
    const { isActive } = req.body;

    if (typeof isActive !== "boolean") {
      return res.status(400).json({
        success: false,
        message: "Le champ 'isActive' doit être un booléen.",
      });
    }

    const user = await User.findById(id);
    if (!user) {
      return res.status(404).json({
        success: false,
        message: "Utilisateur introuvable.",
      });
    }

    user.isActive = isActive;
    await user.save();

    return res.status(200).json({
      success: true,
      message: `Utilisateur ${isActive ? "activé" : "désactivé"} avec succès.`,
    });
  } catch (error) {
    console.error("❌ Erreur désactivation user:", error);
    return res.status(500).json({
      success: false,
      message: "Erreur serveur.",
    });
  }
};

// GET /admin/users?limit=10&offset=0
export const getAllUsers = async (req, res) => {
  try {
    // Vérification admin
    if (!req.user.isAdmin) {
      return res.status(403).json({
        success: false,
        message: "Accès refusé. Réservé aux administrateurs.",
      });
    }

    const { limit = 10, offset = 0, isActive } = req.query; // Ajouter isActive dans les paramètres de requête

    const filter = { isAdmin: false }; // Exclure les administrateurs de la recherche

    // Si le paramètre isActive est fourni, filtrer par statut actif
    if (isActive !== undefined) {
      filter.isActive = isActive === "true"; // Convertir la chaîne 'true' en booléen
    }

    const users = await User.find(filter)
      .skip(Number(offset))
      .limit(Number(limit))
      .sort({ createdAt: -1 });

    const totalUsers = await User.countDocuments(filter);

    // Pour chaque user, récupérer les stats des factures
    const usersWithStats = await Promise.all(
      users.map(async (user) => {
        const totalInvoices = await Invoice.countDocuments({
          userId: user._id,
        });

        const totalAmountAgg = await Invoice.aggregate([
          { $match: { userId: user._id } },
          { $group: { _id: null, totalAmount: { $sum: "$amount" } } },
        ]);

        const totalAmount =
          totalAmountAgg.length > 0 ? totalAmountAgg[0].totalAmount : 0;

        return {
          id: user._id,
          legalName: user.legalName,
          ice: user.ice,
          email: user.email,
          isActive: user.isActive,
          totalInvoices,
          totalAmount,
        };
      })
    );

    return res.status(200).json({
      success: true,
      totalUsers,
      users: usersWithStats,
    });
  } catch (error) {
    console.error("❌ Erreur récupération users admin:", error);
    return res.status(500).json({
      success: false,
      message: "Erreur serveur.",
    });
  }
};

// GET /admin/invoices
// Route pour récupérer les factures globales
export const getAllInvoicesForAdmin = async (req, res) => {
  try {
    if (!req.user.isAdmin) {
      return res.status(403).json({
        success: false,
        message: "Accès refusé. Réservé aux administrateurs.",
      });
    }

    const { limit = 10, offset = 0, startDate, endDate } = req.query;
    const filter = {};

    // Optionnel : filtre date
    if (startDate || endDate) {
      filter.createdAt = {};
      if (startDate) filter.createdAt.$gte = new Date(startDate);
      if (endDate) filter.createdAt.$lte = new Date(endDate);
    }

    const invoices = await Invoice.find(filter)
      .populate("userId", "legalName ice email") // <-- AJOUT
      .skip(Number(offset))
      .limit(Number(limit))
      .sort({ createdAt: -1 });

    const totalInvoices = await Invoice.countDocuments(filter);

    res.status(200).json({
      success: true,
      totalInvoices,
      invoices,
    });
  } catch (error) {
    console.error("Erreur admin récupération factures globales:", error);
    res.status(500).json({
      success: false,
      message: "Erreur serveur.",
    });
  }
};

export const getInvoicesForAdmin = async (req, res) => {
  try {
    if (!req.user.isAdmin) {
      return res.status(403).json({
        success: false,
        message: "Accès refusé. Réservé aux administrateurs.",
      });
    }

    const { userId } = req.params; // userId peut être null
    const {
      limit = 10,
      offset = 0,
      startDate,
      endDate,
      keyword, // <-- Ajout ici
    } = req.query;

    // Si `userId` est fourni, filtre sur cet utilisateur, sinon récupère toutes les factures
    const filter = userId ? { userId } : {};

    // 🔍 Ajout filtre fileName si keyword est présent
    if (keyword) {
      filter.fileName = { $regex: keyword, $options: "i" };
    }

    // 📅 Optionnel : filtrage par date
    if (startDate || endDate) {
      filter.createdAt = {};
      if (startDate) filter.createdAt.$gte = new Date(startDate);
      if (endDate) filter.createdAt.$lte = new Date(endDate);
    }

    const invoices = await Invoice.find(filter)
      .populate("userId", "legalName ice email")
      .skip(Number(offset))
      .limit(Number(limit))
      .sort({ createdAt: -1 });

    const totalInvoices = await Invoice.countDocuments(filter);

    res.status(200).json({
      success: true,
      totalInvoices,
      invoices,
    });
  } catch (error) {
    console.error("Erreur admin récupération factures:", error);
    res.status(500).json({
      success: false,
      message: "Erreur serveur.",
    });
  }
};

// Route pour rechercher un utilisateur par mot-clé (email, ICE, legalName)
export const searchUsers = async (req, res) => {
  try {
    if (!req.user.isAdmin) {
      return res.status(403).json({
        success: false,
        message: "Accès refusé. Réservé aux administrateurs.",
      });
    }

    const { keyword = "", limit = 10, offset = 0, isActive } = req.query;

    let searchFilter = keyword
      ? {
          $or: [
            { email: { $regex: keyword, $options: "i" } },
            { ice: { $regex: keyword, $options: "i" } },
            { legalName: { $regex: keyword, $options: "i" } },
          ],
        }
      : {};

    if (isActive !== undefined) {
      searchFilter.isActive = isActive === "true";
    }

    const users = await User.find({ isAdmin: false, ...searchFilter })
      .skip(Number(offset))
      .limit(Number(limit))
      .sort({ createdAt: -1 });

    const total = await User.countDocuments({
      isAdmin: false,
      ...searchFilter,
    });

    // Ajout de mapping + stats (même format que getAllUsers)
    const usersWithStats = await Promise.all(
      users.map(async (user) => {
        const totalInvoices = await Invoice.countDocuments({
          userId: user._id,
        });

        const totalAmountAgg = await Invoice.aggregate([
          { $match: { userId: user._id } },
          { $group: { _id: null, totalAmount: { $sum: "$amount" } } },
        ]);

        const totalAmount =
          totalAmountAgg.length > 0 ? totalAmountAgg[0].totalAmount : 0;

        return {
          id: user._id, // ← important : transforme _id → id
          legalName: user.legalName,
          ice: user.ice,
          email: user.email,
          isActive: user.isActive,
          totalInvoices,
          totalAmount,
        };
      })
    );

    res.status(200).json({
      success: true,
      totalUsers: total,
      users: usersWithStats,
    });
  } catch (error) {
    console.error("Erreur recherche utilisateurs:", error);
    res.status(500).json({
      success: false,
      message: "Erreur serveur.",
    });
  }
};

// Helper pour __dirname en ESM
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

export const downloadInvoiceForAdmin = async (req, res) => {
  try {
    // Vérifie l'admin
    if (!req.user.isAdmin) {
      return res.status(403).json({
        success: false,
        message: "Accès refusé. Réservé aux administrateurs.",
      });
    }

    const { invoiceId } = req.params;
    const invoice = await Invoice.findById(invoiceId);

    if (!invoice) {
      return res.status(404).json({
        success: false,
        message: "Facture introuvable",
      });
    }

    const baseUrl = `${req.protocol}://${req.get("host")}`;
    const fileName = invoice.fileName;
    const fileUrl = `${baseUrl}/uploads/${fileName}`;

    res.status(200).json({
      success: true,
      message: "URL de téléchargement générée avec succès",
      downloadUrl: fileUrl,
      fileName: fileName,
    });
  } catch (error) {
    console.error("❌ Erreur admin download facture:", error);
    res.status(500).json({
      success: false,
      message: "Erreur serveur lors du téléchargement",
    });
  }
};
export const getWeeklyInvoiceStats = async (req, res) => {
  try {
    if (!req.user.isAdmin) {
      return res.status(403).json({
        success: false,
        message: "Accès refusé. Réservé aux administrateurs.",
      });
    }

    const today = new Date();
    const sevenDaysAgo = new Date();
    sevenDaysAgo.setDate(today.getDate() - 6); // 6 jours + aujourd’hui = 7

    const stats = await Invoice.aggregate([
      {
        $match: {
          createdAt: {
            $gte: new Date(sevenDaysAgo.setHours(0, 0, 0, 0)),
            $lte: new Date(today.setHours(23, 59, 59, 999)),
          },
        },
      },
      {
        $group: {
          _id: {
            $dateToString: { format: "%Y-%m-%d", date: "$createdAt" },
          },
          count: { $sum: 1 },
        },
      },
      {
        $sort: { _id: 1 },
      },
    ]);

    res.status(200).json({
      success: true,
      stats,
    });
  } catch (error) {
    console.error("Erreur stats hebdo factures:", error);
    res.status(500).json({
      success: false,
      message: "Erreur serveur lors de la récupération des stats.",
    });
  }
};
export const getMonthlyInvoiceStats = async (req, res) => {
  try {
    if (!req.user.isAdmin) {
      return res.status(403).json({
        success: false,
        message: "Accès refusé. Réservé aux administrateurs.",
      });
    }

    const year = new Date().getFullYear();

    const stats = await Invoice.aggregate([
      {
        $match: {
          createdAt: {
            $gte: new Date(`${year}-01-01T00:00:00.000Z`),
            $lte: new Date(`${year}-12-31T23:59:59.999Z`),
          },
        },
      },
      {
        $group: {
          _id: {
            $dateToString: { format: "%Y-%m", date: "$createdAt" },
          },
          count: { $sum: 1 },
        },
      },
      { $sort: { _id: 1 } },
    ]);

    res.status(200).json({
      success: true,
      stats,
    });
  } catch (error) {
    console.error("Erreur stats mensuelles factures:", error);
    res.status(500).json({
      success: false,
      message: "Erreur serveur lors de la récupération des stats mensuelles.",
    });
  }
};
export const getUserStatusStats = async (req, res) => {
  try {
    if (!req.user.isAdmin) {
      return res.status(403).json({
        success: false,
        message: "Accès refusé. Réservé aux administrateurs.",
      });
    }

    const stats = await User.aggregate([
      {
        $group: {
          _id: "$isActive",
          count: { $sum: 1 },
        },
      },
    ]);

    // Formater proprement les résultats
    const result = {
      active: 0,
      inactive: 0,
    };

    stats.forEach((stat) => {
      if (stat._id === true) result.active = stat.count;
      if (stat._id === false) result.inactive = stat.count;
    });

    res.status(200).json({
      success: true,
      ...result,
    });
  } catch (error) {
    console.error("Erreur stats utilisateurs actifs/inactifs:", error);
    res.status(500).json({
      success: false,
      message: "Erreur serveur.",
    });
  }
};
export const getPlatformAdoptionStats = async (req, res) => {
  try {
    if (!req.user.isAdmin) {
      return res.status(403).json({
        success: false,
        message: "Accès refusé.",
      });
    }

    const users = await User.aggregate([
      {
        $lookup: {
          from: "invoices",
          localField: "_id",
          foreignField: "userId",
          as: "invoices",
        },
      },
      {
        $project: {
          isFirstLogin: 1,
          hasInvoices: { $gt: [{ $size: "$invoices" }, 0] },
        },
      },
      {
        $group: {
          _id: {
            isFirstLogin: "$isFirstLogin",
            hasInvoices: "$hasInvoices",
          },
          count: { $sum: 1 },
        },
      },
    ]);

    let neverReturned = 0;
    let returnedButInactive = 0;
    let activeUsers = 0;

    users.forEach((u) => {
      if (u._id.isFirstLogin === true) {
        neverReturned += u.count;
      } else if (u._id.isFirstLogin === false && u._id.hasInvoices === true) {
        activeUsers += u.count;
      } else if (u._id.isFirstLogin === false && u._id.hasInvoices === false) {
        returnedButInactive += u.count;
      }
    });

    res.status(200).json({
      success: true,
      neverReturned,
      returnedButInactive,
      activeUsers,
    });
  } catch (error) {
    console.error("Erreur stats adoption:", error);
    res.status(500).json({
      success: false,
      message: "Erreur serveur.",
    });
  }
};
export const getAdminDashboardStats = async (req, res) => {
  try {
    if (!req.user.isAdmin) {
      return res.status(403).json({ success: false, message: "Accès refusé" });
    }

    const [totalUsers, totalInvoices] = await Promise.all([
      User.countDocuments(),
      Invoice.countDocuments(),
    ]);

    res.status(200).json({ success: true, totalUsers, totalInvoices });
  } catch (error) {
    console.error("Erreur dashboard admin:", error);
    res.status(500).json({ success: false, message: "Erreur serveur" });
  }
};
