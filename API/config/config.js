// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getFirestore } from "firebase/firestore";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
const firebaseConfig = {
  apiKey: "AIzaSyBlHVtWWig6DtiGMQzirQo4icSqSCXHXjE",
  authDomain: "jobcom-5cadc.firebaseapp.com",
  projectId: "jobcom-5cadc",
  storageBucket: "jobcom-5cadc.firebasestorage.app",
  messagingSenderId: "351666696001",
  appId: "1:351666696001:web:859a46211ea0f27cb8fbc0",
  measurementId: "G-FF1HM5LVV6"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const db = getFirestore(app);

export default db;