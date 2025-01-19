import express from "express";
import cors from "cors";
import db from "../config/config.js"; // Import sudah benar sekarang
import { collection, addDoc, getDocs, doc, updateDoc, deleteDoc, getDoc } from "firebase/firestore"; // Impor fungsi yang diperlukan

const router = express.Router();

// Tambahkan middleware CORS
router.use(cors());

// Test Connection
router.get("/test", (req, res) => {
  try {
    if (db) {
      res.status(200).send({
        message: "Koneksi ke Firebase berhasil!",
        status: "success"
      });
    } else {
      res.status(500).send({
        message: "Gagal terhubung ke Firebase",
        status: "error" 
      });
    }
  } catch (error) {
    res.status(500).send({
      message: "Terjadi kesalahan saat mengecek koneksi",
      error: error.message,
      status: "error"
    });
  }
});

// Create User
router.post("/", async (req, res) => {
  try {
    const user = req.body;
    const docRef = await addDoc(collection(db, "users"), user); // Gunakan addDoc dan collection
    res.status(201).send({ id: docRef.id, ...user });
  } catch (error) {
    console.error("Error adding user:", error);
    res.status(400).send(error);
  }
});

// Read Users
router.get("/", async (req, res) => {
  try {
    const snapshot = await getDocs(collection(db, "users")); // Menggunakan getDocs untuk mengambil data
    const users = snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
    res.status(200).send(users);
  } catch (error) {
    res.status(400).send(error);
  }
});

// Update User
router.put("/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const userRef = doc(db, "users", id); // Mendapatkan referensi dokumen
    await updateDoc(userRef, req.body); // Menggunakan updateDoc untuk memperbarui data
    res.status(200).send({ id, ...req.body });
  } catch (error) {
    res.status(400).send(error);
  }
});

// Delete User
router.delete("/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const userRef = doc(db, "users", id); // Mendapatkan referensi dokumen
    await deleteDoc(userRef); // Menggunakan deleteDoc untuk menghapus data
    res.status(204).send();
  } catch (error) {
    res.status(400).send(error);
  }
});

// Get Single User
router.get("/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const userRef = doc(db, "users", id);
    const userSnap = await getDoc(userRef);
    
    if (!userSnap.exists()) {
      return res.status(404).send({ message: "User tidak ditemukan" });
    }
    
    res.status(200).send({ id: userSnap.id, ...userSnap.data() });
  } catch (error) {
    res.status(400).send(error);
  }
});

export default router; // Ekspor router
