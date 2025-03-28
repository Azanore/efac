import express from "express";
import auth from "../middlewares/auth.middleware.js";
import Invoice from "../models/invoice.model.js";
import mongoose from "mongoose";

const router = express.Router();

// Route pour GET /api/stats/:id — pour compatibilité avec Flutter
router.get("/:id", auth, async (req, res) => {
  try {
    const userId = new mongoose.Types.ObjectId(req.params.id);

    const totalInvoices = await Invoice.countDocuments({ userId });

    const totalAmount = await Invoice.aggregate([
      { $match: { userId } },
      { $group: { _id: null, totalAmount: { $sum: "$amount" } } },
    ]);
    const totalAmountSum =
      totalAmount.length > 0 ? totalAmount[0].totalAmount : 0;

    const userStats = await Invoice.aggregate([
      { $match: { userId } },
      {
        $group: {
          _id: "$userId",
          totalAmount: { $sum: "$amount" },
          count: { $sum: 1 },
        },
      },
      {
        $lookup: {
          from: "users",
          localField: "_id",
          foreignField: "_id",
          as: "user",
        },
      },
      { $unwind: "$user" },
      {
        $project: {
          "user.email": 1,
          "user.legalName": 1,
          totalAmount: 1,
          count: 1,
        },
      },
    ]);

    res.status(200).json({
      success: true,
      totalInvoices,
      totalAmount: totalAmountSum,
      userStats,
    });
  } catch (error) {
    console.error("Erreur stats Flutter :", error);
    res.status(500).json({
      success: false,
      message: "Erreur récupération statistiques.",
    });
  }
});

export default router;
