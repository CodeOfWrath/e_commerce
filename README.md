# 🛒 E-Commerce Flutter App — Clean Architecture & REST API Real Backend

Application Flutter e-commerce complète connectée à une **API REST réelle (DummyJSON REST API)** avec authentification JWT, mise en cache locale avec **Hive**, mode hors-ligne intelligent et gestion d'erreurs réseau.

---

## 🚀 Fonctionnalités Obligatoires Implémentées

1. **Authentification JWT / REST API** :
   - Connexion (`POST /auth/login`), Inscription (`POST /users/add`), Profil (`GET /auth/me`) et Déconnexion.
   - Stockage sécurisé des tokens `accessToken` et `refreshToken` en cache local avec Hive.
   - Gestion automatique du **Refresh Token** via un `AuthInterceptor` Dio lors de la réception d'un statut HTTP 401.

2. **3 Écrans Connectés à une API REST Réelle** :
   - **Catalogue Produit** (`GET /products?limit=100`) : affichage de la liste des produits avec filtres par catégorie, recherche textuelle et tri par prix.
   - **Détail Produit** (`GET /products/{id}`) : fiche complète avec prix, note (rating), image Hero animation et description.
   - **Profil Utilisateur** (`GET /auth/me`) : affichage des informations du compte connecté via JWT REST API et statut de session.
   - *(Bonus)* Écran **Mon Panier** & écran **Mes Favoris**.

3. **Mise en Cache Locale & Mode Hors-Ligne (Hive)** :
   - Sauvegarde automatique de la liste des produits dans la box Hive `products_box`.
   - Si la connexion Internet est absente ou si une erreur réseau survient, l'application bascule automatiquement sur les données locales du cache Hive.

4. **Gestion d'Erreurs Réseau & Messages Utilisateurs** :
   - Transformation des exceptions Dio/Network en `ServerFailure`, `CacheFailure`, `NetworkFailure` et `UnauthorizedFailure`.
   - Interface utilisateur réactive avec affichage de messages d'erreur explicites et boutons "Réessayer" (`ref.invalidate`).

---

## 🏗️ Architecture Clean (Clean Architecture + Riverpod)

Le projet suit rigoureusement les principes de la **Clean Architecture** découpée en couches indépendantes :

```text
lib/
├── core/
│   ├── error/              # Handling Exceptions & Failures
│   ├── network/            # DioClient, AuthInterceptor (JWT & Refresh), NetworkInfo
│   ├── storage/            # HiveConfig
│   └── utils/              # Router (GoRouter), Providers globaux Riverpod
│
├── features/
│   ├── auth/               # Module Authentification REST API
│   │   ├── data/           # Models, Remote & Local DataSources, RepositoriesImpl
│   │   ├── domain/         # Entities (User, AuthState), Repositories interfaces, UseCases
│   │   └── presentation/   # AuthController (Riverpod Notifier), Pages (Login, Register)
│   │
│   └── ventes/             # Module E-Commerce / Produits
│       ├── data/           # ProductModel, Remote & Local DataSources, RepositoryImpl
│       ├── domain/         # Product Entity, Repository interface
│       ├── Providers/      # Providers Riverpod (Catalog, Cart, Favorites, Filter, User)
│       ├── Screens/        # CatalogScreen, DetailScreen, ProfileScreen, CartScreen, FavoritesScreen
│       └── Widgets/        # ProductCard, FilterBar, CartItem
```

---

## 🌐 Endpoints REST API Utilisés (`https://dummyjson.com`)

| Service | Méthode | Endpoint | Description |
| :--- | :--- | :--- | :--- |
| **Auth Login** | `POST` | `/auth/login` | Authentification JWT (`username`, `password`) |
| **Auth Refresh** | `POST` | `/auth/refresh` | Rafraîchissement du token expiré |
| **Auth Me** | `GET` | `/auth/me` | Récupération du profil utilisateur authentifié |
| **Register** | `POST` | `/users/add` | Inscription d'un nouvel utilisateur |
| **Produits** | `GET` | `/products?limit=100` | Chargement des produits du catalogue |
| **Produit ID** | `GET` | `/products/{id}` | Détail d'un produit spécifique |

---

## 🧪 Tests Unitaires & Widgets

Le projet inclut une suite complète de **28 tests automatisés** :
- **Couche Repository** (`test/ventes/data/product_repository_impl_test.dart` & `test/auth/data/auth_repository_impl_test.dart`) : validation du Repository Pattern, du cache local Hive et du basculement en mode hors-ligne.
- **Providers Riverpod** (`test/ventes/providers/*`) : tests d'états pour le catalogue, le panier, les favoris et le profil utilisateur.
- **Widgets** (`test/ventes/widgets/*`) : validation des composants UI et interactions.

### Lancer les tests :
```bash
flutter test
```

---

## 🛠️ Installation & Configuration

### Prérequis :
- Flutter SDK (v3.10+)
- Dart SDK (v3.0+)

### Étapes :
1. Cloner le dépôt :
   ```bash
   git clone <URL_DU_REPO_GITHUB>
   cd e_commerce
   ```
2. Installer les dépendances :
   ```bash
   flutter pub get
   ```
3. Lancer l'application :
   ```bash
   flutter run
   ```

### Identifiants de test pour la connexion JWT :
- **Utilisateur 1** : Username `emilys` / Password `emilyspass`
- **Utilisateur 2** : Username `kminchelle` / Password `0x8r5e`
