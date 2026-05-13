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
        ElevatedButton(
          onPressed: onContinue,
          child: const Text("I'm ready for the quiz"),
        ),
      ],
    );
  }
}