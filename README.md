# 🛒 Flutter E-commerce App avec Riverpod

## 📖 Description
Application Flutter e-commerce démontrant la maîtrise du **state management avec Riverpod**.  
Fonctionnalités principales :
- Catalogue de produits (liste + détail)
- Panier d’achat (ajout, suppression, quantité)
- Système de favoris persisté localement
- Filtrage et tri des produits
- Écran de profil utilisateur (mock)
- Gestion des états de chargement/erreur avec `AsyncValue`

---

## 📂 Architecture
- `models/` → modèles de données (`Product`)
- `providers/` → logique métier avec Riverpod (`cartProvider`, `favoritesProvider`, etc.)
- `screens/` → pages principales (`CatalogScreen`, `CartScreen`, `ProfileScreen`)
- `widgets/` → composants UI (`ProductCard`, `CartItem`, `FilterBar`)

## 🔑 Providers utilisés
- `FutureProvider` → chargement des produits
- `StateNotifierProvider` → panier, favoris, profil
- `StateProvider` → tri et filtre


## 🧪 Tests
- `test/cart_provider_test.dart` → couverture unitaire du panier


## 🚀 Fonctionnalités
- **Catalogue produits** : affichage, recherche, tri, filtrage
- **Détail produit** : infos dynamiques avec passage de paramètres
- **Panier** : ajout, suppression, modification des quantités
- **Favoris persistés** : stockage local avec `shared_preferences`
- **Profil utilisateur mock** : écran statique + formulaire interactif
- **Gestion des états** : `AsyncValue` pour loading/error/success
- **Bonus** : animation sur l’ajout au panier

---

## 🛠️ Installation

```bash
# Cloner le repo
git clone https://github.com/CodeOfWrath/e_commerce.git
cd e_commerce

# Installer les dépendances
flutter pub get

# Lancer l’application
flutter run
