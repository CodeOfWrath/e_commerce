🛒 Flutter E-commerce App — Architecture Moderne (Riverpod + Firebase)

📖 Description

Application Flutter e-commerce démontrant :
la maîtrise du state management avec Riverpod 2.x
une architecture Clean + Feature-first
l’intégration Firebase Auth (Email/Password)
la gestion d’états asynchrones (AsyncValue, StateNotifier)
la persistance locale (SharedPreferences)
la compatibilité Android / iOS / Web
la séparation stricte Data → Domain → Presentation

Ce projet sert de base solide pour un vrai e-commerce scalable.

---

## 📂 Architecture

---
lib/
└── features/
├── auth/
│    ├── data/
│    │    ├── datasources/
│    │    ├── models/
│    │    └── repositories/
│    ├── domain/
│    │    ├── entities/
│    │    ├── repositories/
│    │    └── usecases/
│    └── presentation/
│         ├── controllers/
│         └── pages/
├── catalog/
├── cart/
├── favorites/
└── profile/
└── core/
├── utils/
├── error/
└── router/
---

models → repositories → providers → screens → widgets

Le projet est organisé en sous-dossiers pour éviter une architecture "flat" :

- `models/` → modèles de données (`Product`, `User`)
- `providers/` → logique métier avec Riverpod (`cartProvider`, `favoritesProvider`, `userProvider`, `productProvider`, `filterProvider`, `catalogProvider`)
- `screens/` → pages principales (`CatalogScreen`, `CartScreen`, `ProfileScreen`, `ProductDetailScreen`, `FavoritesScreen`)
- `widgets/` → composants UI réutilisables (`ProductCard`, `CartItem`, `FilterBar`)
- `assets/` → données mockées (`products.json`)

Cette organisation permet de séparer clairement la logique métier (state management) de la présentation (UI), et de préparer une évolution vers des données réelles (API REST ou GraphQL).

---

## 🔑 Providers utilisés
# Auth
- `StateNotifierProvider<AuthController, AuthState>` → login/register/logout + écoute Firebase
- `StreamProvider<fb.User?>` → état Firebase Auth en temps réel
# Catalogue
- `FutureProvider<List<Product>>` → chargement JSON local ou API
- `StateProvider<String?>` → filtre catégorie
- `StateProvider<SortOption>` → tri
- `Provider<List<Product>>` → catalogue filtré + trié
# Panier
- `StateNotifierProvider<CartNotifier, Map<Product, int>>`
# Favoris

- `StateNotifierProvider<FavoritesNotifier, Set<String>>` → (persistés via SharedPreferences)
# Profil
- `StateNotifierProvider<UserNotifier, User>` → (mock ou Firebase selon version)

👉 Cela fait **7 providers distincts**, bien au-delà du minimum requis.

---

## 🚀 Fonctionnalités
- **Catalogue produits** : affichage, Pull-to-refresh, Hero animation vers ProductDetail, tri et filtrage par catégorie
- **Détail produit** : navigation avec Hero animation et ajout au panier
- **Authentification Firebase** : Login / Register (Email/Password), Gestion des erreurs Firebase, Redirection automatique via GoRouter, État global via AuthController
- **Panier** : ajout, suppression, modification des quantités, calcul du total
- **Favoris persistés** : stockage local avec `SharedPreferences`
- **Profil utilisateur mock** : formulaire interactif + affichage des données mises à jour
- **Gestion des états** : `AsyncValue` pour loading/error/success avec feedback utilisateur (SnackBars, boutons Réessayer)
- **Bonus** : animation sur l’ajout au panier et pull-to-refresh sur le catalogue

---

## 🧪 Tests
Le projet inclut plusieurs fichiers de test pour valider les fonctionnalités principales et les cas limites :

- `test/providers/cart_provider_test.dart` → panier (ajout multiple, suppression, vider le panier)
- `test/providers/favorites_provider_test.dart` → favoris (ajout, suppression, persistance simulée)
- `test/providers/user_provider_test.dart` → profil utilisateur (mise à jour nom/email/ville, persistance locale)
- `test/providers/catalog_provider_test.dart` → logique de tri/filtrage dérivée
- `test/widgets/product_card_test.dart` → interaction UI (ajout au panier, navigation vers détail)
- `test/widgets/catalog_screen_test.dart` → affichage et filtrage du catalogue, navigation vers panier/favoris
- `test/widgets/profile_screen_test.dart` → mise à jour du profil et feedback SnackBar
- `test/error_handling_test.dart` → simulation d’erreurs réseau et vérification du feedback UI

# Erreurs
- `error_handling_test.dart` → (simulateur d’erreurs Firebase + réseau)

Exécution des tests :
```bash
flutter test
```


![Flutter CI](https://github.com/CodeOfWrath/e_commerce/actions/workflows/flutter_ci.yml/badge.svg)


## 🛠️ Installation

```bash
# Cloner le repo
git clone https://github.com/CodeOfWrath/e_commerce.git
cd e_commerce

# Installer les dépendances
flutter pub get

# Lancer l’application
flutter run
