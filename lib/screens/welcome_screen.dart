import 'package:flutter/material.dart';
import '../widgets/parchment_background.dart';
import '../services/local_storage_service.dart';
import '../widgets/brand_logo.dart';

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
    if (checking) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return PatternScaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight - 48),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 440),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const BrandLogo(maxSize: 340),
                      const SizedBox(height: 36),
                      ElevatedButton(
                        onPressed: () => Navigator.pushNamed(context, "/login"),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 56),
                        ),
                        child: const Text("Get Started"),
                      ),
                      const SizedBox(height: 12),
                      OutlinedButton(
                        onPressed: () => Navigator.pushNamed(context, "/signin"),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 56),
                        ),
                        child: const Text("I Already Have an Account"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}