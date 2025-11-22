import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/gradient_appbar.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final user = auth.profile;

    return Scaffold(
      appBar: gradientAppBar('Profil'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CircleAvatar(
            radius: 44,
            backgroundImage: (user?.photoUrl != null) ? NetworkImage(user!.photoUrl!) : null,
            child: (user?.photoUrl == null) ? const Icon(Icons.person, size: 48) : null,
          ),
          const SizedBox(height: 12),
          Center(
            child: Text(
              user?.name ?? auth.firebaseUser?.email ?? 'Kullanıcı',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          Center(child: Text(user?.email ?? auth.firebaseUser?.email ?? '')),
          const SizedBox(height: 24),
          Card(
            child: ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Hesap Oluşturma'),
              subtitle: Text(user?.createdAt.toLocal().toString() ?? ''),
            ),
          ),
          const SizedBox(height: 8),
          const Card(
            child: ListTile(
              leading: Icon(Icons.security),
              title: Text('Gizlilik ve Güvenlik'),
              subtitle: Text('Verilerin yalnızca sana ait. Sadece kendi verini görüntülersin.'),
            ),
          ),
        ],
      ),
    );
  }
}
