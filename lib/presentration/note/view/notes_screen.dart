import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  // 🔥 Dummy data (UI show korar jonno)
  final List<Map<String, String>> notes = [
    {
      "title": "Meeting Notes",
      "description":
          "Discuss project timeline and deliverables.Discuss project timeline and deliverables.Discuss project timeline and deliverables.Discuss project timeline and deliverables.Discuss project timeline and deliverables.Discuss project timeline and deliverables.",
    },
    {"title": "Shopping List", "description": "Milk, Bread, Eggs, Fruits"},
    {
      "title": "Ideas",
      "description": "Build a Flutter app with clean architecture.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Notes"), centerTitle: true),

      body: notes.isEmpty
          ? const Center(
              child: Text("No notes yet 📝", style: TextStyle(fontSize: 16)),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        color: Colors.black.withOpacity(0.05),
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        note["title"]!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        note["description"]!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
            ),

      // 🔥 Floating Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/add-note'); // route
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
