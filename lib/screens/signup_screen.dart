import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../utils/routes.dart';
import '../widgets/error_snackbar.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final name = TextEditingController();
  final email = TextEditingController();
  final pass = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Kayıt Ol')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: name,
                    decoration: const InputDecoration(labelText: 'Ad Soyad'),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: email,
                    decoration: const InputDecoration(labelText: 'E-posta'),
                    validator: (v) => (v == null || !v.contains('@'))
                        ? 'Geçerli bir e-posta girin'
                        : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: pass,
                    decoration: const InputDecoration(labelText: 'Şifre'),
                    obscureText: true,
                    validator: (v) =>
                        (v == null || v.length < 6) ? 'En az 6 karakter' : null,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (!_formKey.currentState!.validate()) return;
                        final err = await auth.signUpWithEmail(
                          email: email.text.trim(),
                          password: pass.text.trim(),
                          displayName: name.text.trim(),
                        );
                        if (!context.mounted) return;
                        if (err != null) {
                          showErrorSnack(context, err);
                        } else {
                          Navigator.pushReplacementNamed(context, Routes.home);
                        }
                      },
                      child: const Text('Kayıt Ol'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
