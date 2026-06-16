//It holds three other screens inside it: 
//Sur, Home, and Raag. When you click a tab 
//at the bottom, MainScreen swaps the middle of 
//the page to show that screen.
import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'sur_lessons_screen.dart';
import 'raag_lessons_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 1;

  final List<Widget> screens = [
    const SurLessonsScreen(),
    const HomeScreen(),
    const RaagLessonsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    const Color brandBlue = Color(0xFF005099);
    return Scaffold(
      body: screens[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        selectedItemColor: brandBlue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.mic),
            label: "Sur",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            label: "Raag",
          ),
        ],
      ),
    );
  }
}