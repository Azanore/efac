import mongoose from "mongoose";

const connectDB = async () => {
  try {
    await mongoose.connect("mongodb://localhost:27017/e_facture_db");
    console.log("Connected to MongoDB");

    const TestModel = mongoose.model(
      "Test",
      new mongoose.Schema({ test: String })
    );
    const doc = await TestModel.create({ test: "test" });
    console.log("Test d'écriture MongoDB réussi:", doc);
    await mongoose.model("Test").deleteMany({});
  } catch (err) {
    console.error("MongoDB error:", err);
  }
};

export default connectDB;
