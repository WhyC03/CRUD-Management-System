# CRUD Management System (Flutter)

A Flutter application developed as an assignment to demonstrate **CRUD operations**, **local SQLite storage**, **Firebase-backed favorites**, **dialog-based editing**, and **real-time search**.

---

## 📱 Features

- ✅ Create, Read, Update, Delete (CRUD) records
- 🗄️ Local storage using **SQLite**
- ⭐ Mark records as Favorites (stored in **Firebase Firestore**)
- 🔐 Firebase **Anonymous Authentication**
- ✏️ Edit records using **Dialog Box**
- 🔍 Real-time search by name or role
- 📱 Clean, assignment-friendly UI
- 📴 Offline-first (records stored locally)

---

## 🧱 Tech Stack

- **Flutter (Dart)**
- **SQLite (sqflite)**
- **Firebase**
  - Firebase Auth (Anonymous)
  - Cloud Firestore
- **Provider** (State Management)

---

## 📂 Project Structure

```
lib/
 ├── db/                 # SQLite database helper
 ├── models/             # Record model
 ├── providers/          # State management
 ├── screens/            # UI screens
 ├── widgets/            # Dialogs & reusable widgets
 ├── services/           # Firebase services
 └── main.dart
```

---

## 🚀 Getting Started

### 1️⃣ Clone the Repository

```
git clone <your-repo-url>
cd crud_management
```

### 2️⃣ Install Dependencies

```
flutter pub get
```

---

## 🔥 Firebase Setup (IMPORTANT)

Firebase-related files are **ignored via .gitignore** for security.

You must add them manually.

### 3️⃣ Create Firebase Project

1. Go to **Firebase Console**
2. Create a new project
3. Add **Android app**
4. Package name:
```
com.virtuous.crud_management
```

---

### 4️⃣ Add `google-services.json`

- Download from Firebase Console
- Place it at:

```
android/app/google-services.json
```

⚠️ This file is ignored in git and must be added manually.

---

### 5️⃣ Enable Anonymous Authentication

Firebase Console → Authentication → Sign-in method  
Enable:

```
Anonymous
```

---

### 6️⃣ Add Firestore Database

Firebase Console → Firestore Database  
Create database in **test mode** (for assignment)

---

### 7️⃣ Add `firebase_options.dart`

Generate using FlutterFire CLI:

```
dart pub global activate flutterfire_cli
flutterfire configure
```

This will generate:

```
lib/firebase_options.dart
```

⚠️ This file is ignored in git and must be generated locally.

---

### 8️⃣ (Optional) firebase.json

If using Firebase CLI features:

```
firebase init
```

This creates:

```
firebase.json
```

⚠️ Also ignored via .gitignore.

---

## ▶️ Run the App

```
flutter run
```

---

## 🧪 Testing Checklist

- ➕ Add record → stored in SQLite
- ✏️ Edit record → dialog opens with pre-filled data
- 🗑 Delete record → removed locally
- ⭐ Mark favorite → stored in Firebase
- 🔁 Restart app → data persists
- 🔍 Search works in real-time

---

## 🧾 Git Ignore Notes

The following files are intentionally ignored for security:

```
android/app/google-services.json
lib/firebase_options.dart
firebase.json
```
---
