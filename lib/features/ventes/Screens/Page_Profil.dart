import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/providers.dart';

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
    final userProfile = ref.read(userProvider);
    _nameController = TextEditingController(text: userProfile.name);
    _emailController = TextEditingController(text: userProfile.email);
    _cityController = TextEditingController(text: userProfile.city);
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

    await notifier.updateName(_nameController.text);
    await notifier.updateEmail(_emailController.text);
    await notifier.updateCity(_cityController.text);

    if (!mounted) return;
    setState(() => _loading = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profil mis à jour')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProfile = ref.watch(userProvider);
    final authState = ref.watch(authControllerProvider);
    final authUser = authState.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil utilisateur'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Déconnexion',
            onPressed: () async {
              final navigator = Navigator.of(context);
              await ref.read(authControllerProvider.notifier).logout();
              if (!mounted) return;
              navigator.pushNamedAndRemoveUntil('/', (route) => false);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Theme.of(context).primaryColor,
              child: authUser?.image != null && authUser!.image.startsWith('http')
                  ? ClipOval(
                      child: Image.network(
                        authUser.image,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.person, size: 40, color: Colors.white),
                      ),
                    )
                  : const Icon(Icons.person, size: 40, color: Colors.white),
            ),
            const SizedBox(height: 12),

            if (authUser != null) ...[
              Text(
                authUser.fullName,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                authUser.email,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              const Chip(
                avatar: Icon(Icons.verified, size: 16, color: Colors.green),
                label: Text('Session JWT REST API active'),
              ),
            ],

            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nom',
                prefixIcon: Icon(Icons.person_outline),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(
                labelText: 'Ville',
                prefixIcon: Icon(Icons.location_city),
              ),
            ),

            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _loading ? null : _saveProfile,
                child: _loading
                    ? const CircularProgressIndicator()
                    : const Text('Enregistrer'),
              ),
            ),

            const SizedBox(height: 30),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Informations actuelles:', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('Nom actuel: ${userProfile.name}'),
                    Text('Email actuel: ${userProfile.email}'),
                    Text('Ville actuel: ${userProfile.city}'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextButton.icon(
              icon: const Icon(Icons.power_settings_new, color: Colors.red),
              label: const Text('Se déconnecter', style: TextStyle(color: Colors.red)),
              onPressed: () async {
                final navigator = Navigator.of(context);
                await ref.read(authControllerProvider.notifier).logout();
                if (!mounted) return;
                navigator.pushNamedAndRemoveUntil('/', (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
