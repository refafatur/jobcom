import express from "express";
import cors from "cors";
import db from "../config/config.js";
import { collection, getDocs, query, where } from "firebase/firestore";

const router = express.Router();
router.use(cors());

// Route untuk memproses login
router.post('/', async (req, res) => {
    try {
        const { email, password } = req.body;

        if (!email || !password) {
            return res.status(400).json({
                success: false,
                message: 'Email dan password diperlukan'
            });
        }

        // Cari user berdasarkan email
        const usersRef = collection(db, "users");
        const q = query(usersRef, where("email", "==", email));
        const querySnapshot = await getDocs(q);

        if (querySnapshot.empty) {
            return res.status(401).json({
                success: false,
                message: 'Email tidak ditemukan'
            });
        }

        const userData = querySnapshot.docs[0].data();

        // Verifikasi password
        if (userData.password !== password) {
            return res.status(401).json({
                success: false,
                message: 'Password salah'
            });
        }

        // Login berhasil
        res.status(200).json({
            success: true,
            message: 'Login berhasil',
            user: {
                id: querySnapshot.docs[0].id,
                email: userData.email,
                nama: userData.nama,
                tipe: userData.tipe
            }
        });

    } catch (error) {
        console.error('Error saat login:', error);
        res.status(500).json({
            success: false,
            message: 'Terjadi kesalahan saat login'
        });
    }
});

export default router;