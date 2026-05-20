import 'package:flutter/material.dart';
import '../services/local_storage_service.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool checking = true;

  @override
  void initState() {
    super.initState();
    checkAuth();
  }

Future<void> checkAuth() async {
  bool isAuth = await LocalStorageService.isLoggedIn();
  if (!mounted) return;
  if (isAuth) {
    Navigator.pushReplacementNamed(context, "/home");
    return;
  }
  setState(() {
    checking = false;
  });
}

  @override
  Widget build(BuildContext context) {
    const Color brandBlue = Color(0xFF005099);

    if (checking) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(),

            Image.asset(
              'assets/images/gurlingo_logo.png',
              height: 400,
              width: 400,
              fit: BoxFit.contain,
            ),

            const Spacer(),
           
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/login");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: brandBlue,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Get Started",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: () {
                    // This sends them to the same login screen
                    Navigator.pushNamed(context, "/signin");
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 56),
                    side: const BorderSide(color: brandBlue, width: 2), // Match the blue
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "I Already Have an Account",
                    style: TextStyle(color: brandBlue, fontWeight: FontWeight.w600),
                  ),
                    
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}