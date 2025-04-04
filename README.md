# 📄 e-Facture

## 📚 Table of Contents

- [✅ Prerequisites](#-prerequisites)
- [🚀 Step-by-step Installation Guide](#-step-by-step-installation-guide)
  - [1. Clone the repository](#1-clone-the-repository)
  - [2. Setup and run the Node.js Backend](#2-setup-and-run-the-nodejs-backend)
  - [3. Setup and run the Flutter Frontend](#3-setup-and-run-the-flutter-frontend)
- [🔐 Environment Configuration](#-environment-configuration)
- [⚠️ Note](#️-note)
- [👨‍💻 Author](#-author)

---

## ✅ Prerequisites

- Install **Node.js** (v16 or newer recommended)
- Install **Flutter SDK** (stable version recommended)
- An IDE or code editor (e.g., VSCode, Android Studio)

### 🔧 Ensure Flutter & Dart SDK Are Up to Date

Make sure you're using **Dart SDK 3.7.0 or newer**.  
If you already have Flutter installed but aren't sure about the version:

```bash
flutter upgrade
```

Then check your Dart version:

```bash
dart --version
```

It should be **3.7.0 or higher** to run this project properly.

- An IDE or code editor (e.g., VSCode, Android Studio)

---

## 🚀 Step-by-step Installation Guide

### 1. Clone the repository

```bash
git clone https://github.com/Azanore/efac.git
cd efac
```

---

### 2. Setup and run the Node.js Backend

Navigate to the backend directory:

```bash
cd e-facture-backend
```

Install dependencies:

```bash
npm install
```

Run the backend server:

```bash
npm start
```

Your Node.js backend will run on: [http://localhost:5000](http://localhost:5000)

---

### 3. Setup and run the Flutter Frontend

Navigate to the frontend directory:

```bash
cd ../e_facture
```

Install Flutter dependencies:

```bash
flutter pub get
```

Connect your emulator or physical device, then run the app:

```bash
flutter run
```

Your Flutter application should start automatically.

---

## 🔐 Environment Configuration

Create a `.env` file in both `e-facture-backend` and `e_facture` directories.

### Example `.env` for backend:

```
MONGODB_URI=mongodb://localhost:27017/e_facture_db
JWT_SECRET=mySuperComplexSecretKeyThatIsHardToGuess123!
JWT_EXPIRATION=3600
PORT=5000
SMTP_USER=MS_tY1r0E@trial-3zxk54v9dvqgjy6v.mlsender.net
SMTP_PASS=mssp.hABhdnu.jy7zpl93zypl5vx6.UszY0wC
```

### Example `.env` for Flutter frontend:

```
API_URL=http://192.168.11.107:5000/api
AUTH_PATH=/user/auth
INVOICE_PATH=/user/invoices
```

---

## ⚠️ Note

Generated files and folders (like `node_modules`, `build`, `.dart_tool`, etc.) are excluded from Git and automatically recreated during setup.

---

## 👨‍💻 Author

Developed by **Abderrahim Oumous**  
📧 Contact: [abderrahim.oumous1@gmail.com](mailto:abderrahim.oumous1@gmail.com)
