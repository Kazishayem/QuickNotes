import 'package:flutter/material.dart';
import 'package:quicknotes/core/constants/color_manager.dart';

class NoteDetailsScreen extends StatelessWidget {
  final String title;
  final String description;

  const NoteDetailsScreen({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Note Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              description,
              style: const TextStyle(
                fontSize: 16,
                color: ColorManager.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}