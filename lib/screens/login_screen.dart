import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../utils/routes.dart';
import '../widgets/error_snackbar.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final pass = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    email.dispose();
    pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Giriş Yap')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: AutofillGroup(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: email,
                      autofillHints: const [AutofillHints.email],
                      decoration: const InputDecoration(labelText: 'E-posta'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) =>
                          (v == null || !v.contains('@')) ? 'Geçerli bir e-posta girin' : null,
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
                          final err = await auth.signInWithEmail(email.text.trim(), pass.text.trim());
                          if (err != null) {
                            showErrorSnack(context, err);
                          } else {
                            if (!mounted) return;
                            Navigator.pushReplacementNamed(context, Routes.home);
                          }
                        },
                        child: const Text('E-posta ile Giriş'),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.account_circle),
                        label: const Text('Google ile Giriş'),
                        onPressed: () async {
                          final err = await auth.signInWithGoogle();
                          if (err != null) {
                            showErrorSnack(context, err);
                          } else {
                            if (!mounted) return;
                            Navigator.pushReplacementNamed(context, Routes.home);
                          }
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (auth.isAppleAvailable)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.apple),
                          label: const Text('Apple ile Giriş'),
                          onPressed: () async {
                            final err = await auth.signInWithApple();
                            if (err != null) {
                              showErrorSnack(context, err);
                            } else {
                              if (!mounted) return;
                              Navigator.pushReplacementNamed(context, Routes.home);
                            }
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                        ),
                      ),
                    const SizedBox(height: 14),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, Routes.signup),
                      child: const Text('Hesabın yok mu? Kayıt ol'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
