import 'package:e_commerce/features/auth/presentation/pages/login_page.dart';
import 'package:e_commerce/features/ventes/Screens/Page_Catalogue.dart';
import 'package:e_commerce/features/ventes/Screens/Page_Favorit.dart';
import 'package:e_commerce/features/ventes/Screens/Page_Profil.dart';
import 'package:e_commerce/features/ventes/Screens/Pages_Carte.dart';
import 'package:go_router/go_router.dart';

// ------------------------------------------------------------
// ROUTER COMPLET
// ------------------------------------------------------------
final router = GoRouter(
  initialLocation: '/',
  routes: [

    // --------------------------------------------------------
    // PAGE PRINCIPALE AVEC BOTTOM NAVIGATION
    // --------------------------------------------------------
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginPage(),
    ),

    // --------------------------------------------------------
    // PRODUITS
    // --------------------------------------------------------
    GoRoute(
      path: '/product/:id',
      builder: (context, state) {
        //final id = state.pathParameters['id']!;
        return CatalogScreen();
      },
    ),

    // --------------------------------------------------------
    // PANIER
    // --------------------------------------------------------
    GoRoute(
      path: '/cart',
      builder: (context, state) => const CartScreen(),
    ),

    // --------------------------------------------------------
    // FAVORIS
    // --------------------------------------------------------
    GoRoute(
      path: '/favorites',
      builder: (context, state) => const FavoritesScreen(),
    ),

    // --------------------------------------------------------
    // PROFIL
    // --------------------------------------------------------
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),

  ],
);
