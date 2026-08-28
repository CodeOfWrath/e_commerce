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

  void _saveProfile() {
    ref.read(userProvider.notifier).updateName(_nameController.text);
    ref.read(userProvider.notifier).updateEmail(_emailController.text);
    ref.read(userProvider.notifier).updateCity(_cityController.text);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profil mis à jour')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);

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
              onPressed: _saveProfile,
              child: const Text('Enregistrer'),
            ),
            const SizedBox(height: 20),
            // Affichage des infos actuelles
            Text('Nom actuel: ${user.name}'),
            Text('Email actuel: ${user.email}'),
            Text('Ville actuelle: ${user.city}'),
          ],
        ),
      ),
    );
  }
}
