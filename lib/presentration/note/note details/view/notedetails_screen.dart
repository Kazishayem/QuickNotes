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
      appBar: AppBar(title: const Text('Note Details')),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: ColorManager.softBackgroundGradient,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x14000000),
                    blurRadius: 18,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Container(
                    height: 1,
                    color: Colors.black.withValues(alpha: 0.08),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.55,
                      color: Colors.black.withValues(alpha: 0.78),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
