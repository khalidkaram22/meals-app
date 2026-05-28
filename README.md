# 🍽️ Meals App

A Flutter application for browsing, searching, and saving meals using TheMealDB API.  
The app demonstrates clean architecture concepts, state management with BLoC/Cubit, and local persistence using SQLite.

---

## 🚀 Features

- 🔍 Search meals by name
- 🍱 Browse meals by categories
- 📖 View detailed meal information
- ❤️ Add/remove favorite meals
- 💾 Offline access using local SQLite database
- 📱 Clean and responsive UI

---

## 🏗️ Architecture

This project uses a **feature-based architecture** with Cubit (BLoC pattern):

<pre>
lib/
├── core/
│   ├── network/
│   ├── database/
│   ├── styles/
│   └── widgets/
│
├── features/
│   ├── home_screen/
│   ├── search_result_screen/
│   ├── my_meals/
│   ├── meal_details/
│   └── add_meals_screen/
</pre>


### State Management
- Flutter Bloc (Cubit)
- Feature-based Cubits per screen

---

## 🧠 Tech Stack

- Flutter
- Dart
- BLoC / Cubit
- Dio (API requests)
- SQLite (local storage)
- GoRouter (navigation)

---

## 🌐 API

This app uses:
- [TheMealDB API](https://www.themealdb.com/api.php)

---

## 📦 Local Storage

Meals are stored locally using SQLite to allow offline access to saved meals.

---

## 📸 Screens

- Home Screen (Categories + Meals)
- Search Screen
- Meal Details Screen
- My Meals (Favorites)
- Add Meal Screen

---

## 🧩 State Management Overview

- `HomeCubit` → handles categories & meals from API
- `SearchCubit` → handles search functionality
- `MyMealsCubit` → handles local saved meals
- `MealDetailsCubit` → handles meal details view state

---

## ⚠️ Notes

- This project is currently in active refactoring.
- Architecture will be improved to introduce a global Favorites state and better separation of concerns.

---

## 📈 Future Improvements

- Add dependency injection (get_it)
- Implement offline-first architecture
- Improve caching strategy
- Add animations and UI enhancements
- Improve test coverage

---

## 👨‍💻 Developer

Built by Khalid Karam as part of Flutter learning and portfolio development.
