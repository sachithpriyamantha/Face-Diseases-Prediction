import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminSignIn extends StatefulWidget {
  const AdminSignIn({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AdminSignInState createState() => _AdminSignInState();
}

class _AdminSignInState extends State<AdminSignIn> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/admin');
    } catch (e) {
      // Handle errors or display an alert
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: signIn, child: const Text('Login'))
          ],
        ),
      ),
    );
  }
}
