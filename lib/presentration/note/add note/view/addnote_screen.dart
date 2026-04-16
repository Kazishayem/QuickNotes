import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quicknotes/presentration/common%20widget/custom_text_field.dart';
import 'package:quicknotes/presentration/common%20widget/primary_button.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final titleController = TextEditingController();
  final descController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Note"), centerTitle: true),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔹 Title Field
            CustomTextField(
              controller: titleController,
              hintText: 'Enter title',
            ),

            const SizedBox(height: 15),

            // 🔹 Description Field
            CustomTextField(
              hintText: "Enter description",
              controller: descController,
              maxLines: 5, 
              minLines: 5,
            ),

            const SizedBox(height: 25),

            // 🔥 Save Button
            PrimaryButton(
              title: "Save Note",
              onPressed: () {
                context.push("/notes");
              },
            ),
          ],
        ),
      ),
    );
  }
}
