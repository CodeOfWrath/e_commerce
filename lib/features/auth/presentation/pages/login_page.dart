import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/providers.dart';
import '../../../ventes/Screens/Page_Catalogue.dart';
import 'register_page.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _usernameController = TextEditingController(text: 'emilys');
  final _passwordController = TextEditingController(text: 'emilyspass');

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Connexion JWT REST API')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.lock_person_outlined, size: 80, color: Colors.blue),
            const SizedBox(height: 16),
            const Text(
              'Bienvenue sur l\'E-Commerce',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Authentification JWT via API REST DummyJSON',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),

            if (state.error != null) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.withAlpha(30),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red.withAlpha(100)),
                ),
                child: Text(
                  state.error!,
                  style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),
            ],

            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Nom d\'utilisateur ou Email',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
                helperText: 'Compte démo REST: emilys ou kminchelle',
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Mot de passe',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
                helperText: 'Mot de passe démo REST: emilyspass ou 0x8r5e',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),

            if (state.isLoading)
              const Center(child: CircularProgressIndicator())
            else
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () async {
                  final navigator = Navigator.of(context);
                  await ref
                      .read(authControllerProvider.notifier)
                      .login(_usernameController.text, _passwordController.text);

                  if (!mounted) return;
                  if (ref.read(authControllerProvider).user != null) {
                    navigator.pushReplacement(
                      MaterialPageRoute(builder: (_) => const CatalogScreen()),
                    );
                  }
                },
                child: const Text('Se connecter (JWT)', style: TextStyle(fontSize: 16)),
              ),

            const SizedBox(height: 12),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CatalogScreen(),
                  ),
                );
              },
              child: const Text('Continuer sans connexion (Mode Invité)'),
            ),

            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Vous n\'avez pas de compte ?'),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const RegisterPage(),
                      ),
                    );
                  },
                  child: const Text('Créer un compte'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
