import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Login / Register')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
            TextField(controller: passwordController, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  await auth.signIn(emailController.text, passwordController.text);
                } catch (e) {
                  // ignore: avoid_print
                  print(e);
                }
              },
              child: const Text('Login'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await auth.signUp(emailController.text, passwordController.text);
                } catch (e) {
                  // ignore: avoid_print
                  print(e);
                }
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
