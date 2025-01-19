import express from "express";
import userRoutes from "./routes/userRoutes.js"; // Pastikan untuk menambahkan .js
import loginRoutes from "./routes/loginRoutes.js"; // Import route login
const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());
app.use("/api/users", userRoutes);
app.use("/api/login", loginRoutes); // Gunakan route login

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
