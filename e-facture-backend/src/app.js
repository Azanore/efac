import express from "express";
import dotenv from "dotenv";
import cors from "cors";
import path from "path";
import { fileURLToPath } from "url";
import fs from "fs";

import connectDB from "./config/db.js";
import authRoutes from "./routes/auth.routes.js";
import invoiceRoutes from "./routes/invoice.routes.js";
import statsRoutes from "./routes/stats.routes.js";
import adminRoutes from "./routes/admin.routes.js";

dotenv.config();

connectDB();

const app = express();
app.use(cors());
app.use(express.json());

// Uploads folder
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const uploadDir = path.join(__dirname, "../uploads");

if (!fs.existsSync(uploadDir)) {
  fs.mkdirSync(uploadDir, { recursive: true });
}

app.use("/uploads", express.static(uploadDir));

app.use("/api/user/auth", authRoutes);
app.use("/api/user/invoices", invoiceRoutes);
app.use("/api/stats", statsRoutes);
app.use("/api/admin", adminRoutes);

app.get("/", (req, res) => {
  res.send("E-Facture API is running");
});

export default app;
