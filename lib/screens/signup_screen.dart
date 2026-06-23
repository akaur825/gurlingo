import 'package:flutter/material.dart';
import '../services/local_storage_service.dart';
import '../services/app_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool loading = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

void handleSignup() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    setState(() => loading = true);

    try {
      // Save to permanent storage & verify uniqueness
      bool success = await LocalStorageService.saveUser(name, email, password);

      if (!mounted) return;

      if (success) {
        // FIX: Pass a Map with the dynamic values to match your UserProgress.fromJson requirements
        AppState.login({
          "username": name,
          "email": email,
          "surLevel": 1,
          "raagLevel": 1,
          "totalXp": 0,
          "streakDays": 1,
          "preferredScale": "C#",
          "completedSurLessons": <String>[],
          "completedRaagLessons": <String>[],
        }); 
        
        Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("An account with this email already exists.")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("An error occurred. Please try again.")),
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
          "Get Started", 
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children:[
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Full Name",
                floatingLabelStyle: TextStyle(color: brandBlue),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: brandBlue, width: 2)),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
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
                labelText: "Create Password",
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
                onPressed: loading ? null : handleSignup,
                style: ElevatedButton.styleFrom(
                  backgroundColor: brandBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: loading 
                  ? const CircularProgressIndicator(color: Colors.white) 
                  : const Text("Create Account"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}