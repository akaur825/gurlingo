import 'package:flutter/material.dart';

class VideoPlaceholder extends StatelessWidget {
  final String description;
  final VoidCallback onContinue;

  const VideoPlaceholder({
    super.key,
    required this.description,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          color: Colors.grey.shade300,
          child: const Center(child: Icon(Icons.play_circle, size: 60)),
        ),
        const SizedBox(height: 20),
        Text(description, style: const TextStyle(fontSize: 16)),
        const Spacer(),
        
        // 👇 UPDATED BUTTON WITH THE NEW STYLING AND PADDING
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: SizedBox(
            width: double.infinity, // This makes the button comfortably wide
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF005099), // Brand Blue
                foregroundColor: Colors.white,            // White Text
                padding: const EdgeInsets.symmetric(vertical: 16), // Thicker button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18), // Smooth corners
                ),
                elevation: 2,
              ),
              onPressed: onContinue,
              child: const Text(
                "I'm ready for the quiz",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}