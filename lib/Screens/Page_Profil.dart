import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Providers/Provider_User.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _cityController;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    final user = ref.read(userProvider);
    _nameController = TextEditingController(text: user.name);
    _emailController = TextEditingController(text: user.email);
    _cityController = TextEditingController(text: user.city);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    setState(() => _loading = true);
    final notifier = ref.read(userProvider.notifier);

    notifier.updateName(_nameController.text);
    notifier.updateEmail(_emailController.text);
    notifier.updateCity(_cityController.text);

    await Future.delayed(const Duration(milliseconds: 500)); // feedback visuel
    setState(() => _loading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profil mis à jour')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider); // ✅ observe les changements

    return Scaffold(
      appBar: AppBar(title: const Text('Profil utilisateur')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
            const SizedBox(height: 20),

            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nom'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(labelText: 'Ville'),
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loading ? null : _saveProfile,
              child: _loading
                  ? const CircularProgressIndicator()
                  : const Text('Enregistrer'),
            ),

            const SizedBox(height: 30),
            // ✅ Affichage des infos mises à jour
            Text('Nom actuel: ${user.name}'),
            Text('Email actuel: ${user.email}'),
            Text('Ville actuelle: ${user.city}'),
          ],
        ),
      ),
    );
  }
}
