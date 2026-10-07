import 'package:e_commerce/core/utils/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (state.error != null)
              Text(state.error!, style: const TextStyle(color: Colors.red)),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Mot de passe'),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            if (state.isLoading)
              const CircularProgressIndicator()
            else
              ElevatedButton(
                onPressed: () async {
                  await ref
                      .read(authControllerProvider.notifier)
                      .login(_emailController.text, _passwordController.text);
                  if (ref.read(authControllerProvider).user != null) {
                    Navigator.pushReplacementNamed(context, '/restaurants');
                  }
                },
                child: const Text('Se connecter'),
              ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const _RegisterPageInline(),
                  ),
                );
              },
              child: const Text('Créer un compte'),
            ),
          ],
        ),
      ),
    );
  }
}

// petite page register inline pour garder simple
class _RegisterPageInline extends ConsumerWidget {
  const _RegisterPageInline();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final state = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (state.error != null)
              Text(state.error!, style: const TextStyle(color: Colors.red)),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Mot de passe'),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            if (state.isLoading)
              const CircularProgressIndicator()
            else
              ElevatedButton(
                onPressed: () async {
                  await ref
                      .read(authControllerProvider.notifier)
                      .register(emailController.text, passwordController.text);
                  if (ref.read(authControllerProvider).user != null) {
                    Navigator.pushReplacementNamed(context, '/restaurants');
                  }
                },
                child: const Text('Créer un compte'),
              ),
          ],
        ),
      ),
    );
  }
}
