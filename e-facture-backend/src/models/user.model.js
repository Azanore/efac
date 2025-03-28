import mongoose from "mongoose";

const userSchema = new mongoose.Schema(
  {
    email: {
      type: String,
      required: true,
      unique: true,
      trim: true,
      lowercase: true,
      match: [
        /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/,
        "Veuillez fournir une adresse email valide",
      ],
    },
    ice: {
      type: String,
      required: true,
      unique: true,
      trim: true,
      minlength: [8, "L'ICE doit comporter au moins 8 caractères"],
      maxlength: [15, "L'ICE ne peut pas dépasser 15 caractères"],
    },
    legalName: {
      type: String,
      required: true,
      unique: true,
      trim: true,
      minlength: [3, "La raison sociale doit comporter au moins 3 caractères"],
      maxlength: [100, "La raison sociale ne peut pas dépasser 100 caractères"],
    },
    password: { type: String, required: true },
    isActive: { type: Boolean, default: true },
    isFirstLogin: { type: Boolean, default: true },
    isAdmin: { type: Boolean, default: false },
  },
  { timestamps: true }
);

const User = mongoose.model("User", userSchema);
export default User;
