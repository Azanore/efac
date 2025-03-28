import Invoice from "../models/invoice.model.js";
import User from "../models/user.model.js";
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";

// ====== Config pour le chemin du dossier uploads ======
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const uploadDir = path.join(__dirname, "../../uploads");

// ===== Créer le dossier uploads s'il n'existe pas =====
if (!fs.existsSync(uploadDir)) {
  fs.mkdirSync(uploadDir, { recursive: true });
}

// ===== Fonction pour sauvegarder le fichier =====
const saveFile = async (file) => {
  try {
    const filePath = path.join(uploadDir, file.originalname);
    await fs.promises.writeFile(filePath, file.buffer);

    return {
      fileName: file.originalname,
      fileUrl: `/uploads/${file.originalname}`,
    };
  } catch (error) {
    console.error("Erreur lors de l'enregistrement du fichier:", error);
    throw new Error("Impossible d'enregistrer le fichier");
  }
};

// ===== Route: Créer une nouvelle facture =====
export const createInvoice = async (req, res) => {
  try {
    const { userId, amount } = req.body;

    // === LOGGING : Vérifions ce qui arrive ===
    console.log("=== Nouvelle facture reçue ===");
    console.log("userId :", userId);
    console.log("amount :", amount);
    console.log("req.file :", req.file);

    if (!userId || !amount || !req.file) {
      console.log("❌ Champs manquants !");
      return res.status(400).json({
        success: false,
        message: "Tous les champs sont obligatoires",
      });
    }

    const invoiceAmount = parseFloat(amount);
    if (isNaN(invoiceAmount) || invoiceAmount <= 5000000) {
      console.log("❌ Montant non valide ou <= 5 000 000 :", invoiceAmount);
      return res.status(400).json({
        success: false,
        message: "Le montant doit être supérieur à 5 000 000",
      });
    }

    // Vérif autorisation utilisateur
    if (req.user._id.toString() !== userId && !req.user.isAdmin) {
      console.log("❌ Utilisateur non autorisé :", req.user._id, "vs", userId);
      return res.status(403).json({
        success: false,
        message:
          "Vous n'êtes pas autorisé à créer une facture pour cet utilisateur",
      });
    }

    const user = await User.findById(userId);
    if (!user) {
      console.log("❌ Utilisateur introuvable :", userId);
      return res.status(404).json({
        success: false,
        message: "Utilisateur non trouvé",
      });
    }

    const now = new Date();
    const day = String(now.getDate()).padStart(2, "0");
    const month = String(now.getMonth() + 1).padStart(2, "0");
    const year = String(now.getFullYear()).slice(-2);
    const hours = String(now.getHours()).padStart(2, "0");
    const minutes = String(now.getMinutes()).padStart(2, "0");
    const seconds = String(now.getSeconds()).padStart(2, "0");
    const milliseconds = String(now.getMilliseconds()).padStart(3, "0");

    const newFileName = `INV-${day}-${month}-${year}-${hours}-${minutes}-${seconds}-${milliseconds}-${user.ice}.pdf`;
    req.file.originalname = newFileName;

    const fileInfo = await saveFile(req.file);

    const newInvoice = new Invoice({
      userId,
      fileName: fileInfo.fileName,
      fileUrl: fileInfo.fileUrl,
      amount: invoiceAmount,
    });

    await newInvoice.save();

    console.log("✅ Facture créée avec succès :", newInvoice);

    res.status(201).json({
      success: true,
      message: "Facture ajoutée avec succès",
      invoice: newInvoice,
    });
  } catch (error) {
    console.error("❌ Erreur lors de la création de la facture:", error);
    res.status(500).json({
      success: false,
      message: error.message || "Erreur lors de la création de la facture",
    });
  }
};

// ===== Route: Récupérer les factures d'un utilisateur =====
export const getInvoicesByUser = async (req, res) => {
  try {
    const { userId } = req.params;
    const { limit = 10, offset = 0 } = req.query;

    if (req.user._id.toString() !== userId && !req.user.isAdmin) {
      return res.status(403).json({
        success: false,
        message: "Vous n'êtes pas autorisé à accéder à ces factures",
      });
    }

    const invoices = await Invoice.find({ userId })
      .skip(Number(offset))
      .limit(Number(limit))
      .sort({ createdAt: -1 });

    const count = await Invoice.countDocuments({ userId });

    res.status(200).json({
      success: true,
      totalInvoices: count,
      invoices,
    });
  } catch (error) {
    console.error("Erreur lors de la récupération des factures:", error);
    res.status(500).json({
      success: false,
      message: "Erreur lors de la récupération des factures",
    });
  }
};

// ===== Route: Télécharger une facture =====
export const downloadInvoice = async (req, res) => {
  try {
    const { invoiceId } = req.params;
    const invoice = await Invoice.findById(invoiceId);
    if (!invoice) {
      return res.status(404).json({
        success: false,
        message: "Facture non trouvée",
      });
    }

    if (
      req.user._id.toString() !== invoice.userId.toString() &&
      !req.user.isAdmin
    ) {
      return res.status(403).json({
        success: false,
        message: "Vous n'êtes pas autorisé à télécharger cette facture",
      });
    }

    const baseUrl = `${req.protocol}://${req.get("host")}`;
    const fileUrl = `${baseUrl}/uploads/${path.basename(invoice.fileUrl)}`;

    res.json({
      success: true,
      message: "URL de téléchargement générée avec succès",
      downloadUrl: fileUrl,
      fileName: invoice.fileName,
    });
  } catch (error) {
    console.error(
      "Erreur lors de la génération de l'URL de téléchargement:",
      error
    );
    res.status(500).json({
      success: false,
      message: "Une erreur est survenue. Veuillez réessayer plus tard.",
    });
  }
};

// ===== Route: Statistiques =====
export const getStats = async (req, res) => {
  try {
    const userId = req.user._id;

    // Nombre total de factures
    const totalInvoices = await Invoice.countDocuments({ userId });

    // Somme totale des montants
    const totalAmountAggregate = await Invoice.aggregate([
      { $match: { userId: new mongoose.Types.ObjectId(userId) } },
      { $group: { _id: null, totalAmount: { $sum: "$amount" } } },
    ]);

    const totalAmount =
      totalAmountAggregate.length > 0 ? totalAmountAggregate[0].totalAmount : 0;

    res.status(200).json({
      success: true,
      totalInvoices,
      totalAmount,
    });
  } catch (error) {
    console.error("Erreur lors de la récupération des statistiques:", error);
    res.status(500).json({
      success: false,
      message: "Erreur lors de la récupération des statistiques.",
    });
  }
};
// ===== Route: Récupérer les factures filtrées par date (utilisateur) =====
export const getUserInvoicesWithDateFilter = async (req, res) => {
  try {
    const { startDate, endDate, limit = 10, offset = 0 } = req.query;
    const userId = req.user._id;

    const filter = { userId };

    if (startDate || endDate) {
      filter.createdAt = {};
      if (startDate) filter.createdAt.$gte = new Date(startDate);
      if (endDate) filter.createdAt.$lte = new Date(endDate);
    }

    const invoices = await Invoice.find(filter)
      .skip(Number(offset))
      .limit(Number(limit))
      .sort({ createdAt: -1 });

    const count = await Invoice.countDocuments(filter);

    res.status(200).json({
      success: true,
      totalInvoices: count,
      invoices,
    });
  } catch (error) {
    console.error("Erreur filtrage factures utilisateur:", error);
    res.status(500).json({
      success: false,
      message: "Erreur lors de la récupération des factures.",
    });
  }
};
