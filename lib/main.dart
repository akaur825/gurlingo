import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/signin_screen.dart';
import 'screens/main_screen.dart';
import 'services/app_state.dart';
import 'theme/app_theme.dart';
import 'widgets/responsive.dart';

// 1. Mark main as 'async'
void main() async {
  // 2. Add this line - it's the "bridge" between Flutter and the phone
  WidgetsFlutterBinding.ensureInitialized();

  // 3. Restore the saved session (if any) before the app starts
  await AppState.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gurlingo',
      theme: AppTheme.light(),
      builder: (context, child) => AppFrame(child: child ?? const SizedBox()),
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        overscroll: false, 
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/signin': (context) => const SignInScreen(),
        '/home': (context) => const MainScreen(),
        // Note: You'll want to add your QuizScreen here later!
      },
    );
  }
}