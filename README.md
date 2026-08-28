# 🛒 Flutter E-commerce App avec Riverpod

## 📖 Description
Application Flutter e-commerce démontrant la maîtrise du **state management avec Riverpod**.  
Elle met en avant la séparation logique entre données, providers et UI, tout en respectant les bonnes pratiques Flutter.  
Ce projet est éducatif et vise à valider la compréhension des concepts clés de Riverpod.

---

## 📂 Architecture
Le projet est organisé en sous-dossiers pour éviter une architecture "flat" :
- `models/` → modèles de données (`Product`)
- `providers/` → logique métier avec Riverpod (`cartProvider`, `favoritesProvider`, `userProvider`, etc.)
- `screens/` → pages principales (`CatalogScreen`, `CartScreen`, `ProfileScreen`, `ProductDetailScreen`)
- `widgets/` → composants UI réutilisables (`ProductCard`, `CartItem`, `FilterBar`)

Cette organisation permet de séparer clairement la logique métier (state management) de la présentation (UI).

---

## 🔑 Providers utilisés
- `FutureProvider` → chargement des produits mockés
- `StateNotifierProvider` → gestion du panier, des favoris et du profil utilisateur
- `StateProvider` → options de tri et de filtrage

---

## 🚀 Fonctionnalités
- **Catalogue produits** : affichage, tri et filtrage par catégorie
- **Détail produit** : navigation avec Hero animation et ajout au panier
- **Panier** : ajout, suppression, modification des quantités, calcul du total
- **Favoris persistés** : stockage local avec `SharedPreferences`
- **Profil utilisateur mock** : formulaire interactif + affichage des données mises à jour
- **Gestion des états** : `AsyncValue` pour loading/error/success
- **Bonus** : animation sur l’ajout au panier

---

## 🧪 Tests
Le projet inclut plusieurs fichiers de test pour valider les fonctionnalités principales :
- `test/providers/cart_provider_test.dart` → panier
- `test/providers/favorites_provider_test.dart` → favoris
- `test/providers/user_provider_test.dart` → profil utilisateur
- `test/widgets/product_card_test.dart` → interaction UI (ajout au panier)
- `test/widgets/catalog_screen_test.dart` → affichage et filtrage du catalogue

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
