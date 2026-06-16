//shows the home page w/ progress stuff
import 'package:flutter/material.dart';
import '../widgets/progress_circle.dart';
import '../services/app_state.dart';
import '../models/user_progress.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AppState.currentUser ?? UserProgress(username: "Guest");

    final totalLessons =
        user.completedSurLessons.length + user.completedRaagLessons.length;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 👋 HEADER + LOGOUT
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "ਵਾਹਿਗੁਰੂ ਜੀ ਕਾ ਖਾਲਸਾ ਵਾਹਿਗੁਰੂ ਜੀ ਕੀ ਫਤਿਹ",
                          style:
                              TextStyle(fontSize: 16, color: Color.fromARGB(255, 51, 51, 51)),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Welcome, ${user.username}",
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 🚪 SIGN OUT BUTTON
                  IconButton(
                    icon: const Icon(Icons.logout),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Sign Out"),
                          content: const Text(
                            "Are you sure you want to Sign Out?",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () async {
                                // 1. Wipe memory AND local storage
                                await AppState.logout();

                                if (context.mounted) {
                                  // 2. Clear the screen stack and go to Welcome
                                  Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
                                    '/', 
                                    (route) => false,
                                  );
                                }
                              },
                              child: const Text("Sign Out", style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // 📊 STATS CARDS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatCard(
                    Icons.local_fire_department,
                    user.streakDays.toString(),
                    "Day Streak",
                    Colors.orange,
                  ),
                  _buildStatCard(
                    Icons.flash_on,
                    user.totalXp.toString(),
                    "Total XP",
                    Colors.amber,
                  ),
                  _buildStatCard(
                    Icons.emoji_events,
                    totalLessons.toString(),
                    "Lessons",
                    Colors.blue,
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // 📈 PROGRESS
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Your Progress",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            ProgressCircle(
                              progress:
                                  user.completedSurLessons.length / 8,
                              icon: Icons.mic,
                            ),
                            const SizedBox(height: 10),
                            const Text("Sur"),
                            Text(
                                "${user.completedSurLessons.length}/8"),
                          ],
                        ),
                        Column(
                          children: [
                            ProgressCircle(
                              progress:
                                  user.completedRaagLessons.length / 8,
                              icon: Icons.music_note,
                            ),
                            const SizedBox(height: 10),
                            const Text("Raag"),
                            Text(
                                "${user.completedRaagLessons.length}/8"),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
      IconData icon, String value, String label, Color color) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}