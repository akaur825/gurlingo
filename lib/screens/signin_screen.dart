import 'package:flutter/material.dart';
import '../services/local_storage_service.dart';
import '../services/app_state.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool loading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void handleLogin() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    setState(() => loading = true);

    try {
      final matchedUser = await LocalStorageService.authenticateUser(email, password);

      if (!mounted) return;

      if (matchedUser != null) {
        // FIX: Pass the complete map object containing credentials and history
        AppState.login(matchedUser); 
        Navigator.pushNamedAndRemoveUntil(context, "/home", (route)=> false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Invalid email or password")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("An error occurred during login.")),
      );
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color brandBlue = Color(0xFF005099);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: brandBlue), 
        title: const Text(
          "Log In", 
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
        )
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                floatingLabelStyle: TextStyle(color: brandBlue),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: brandBlue, width: 2)),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                floatingLabelStyle: TextStyle(color: brandBlue),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: brandBlue, width: 2)),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: loading ? null : handleLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: brandBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: loading 
                  ? const CircularProgressIndicator(color: Colors.white) 
                  : const Text("Log In"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}