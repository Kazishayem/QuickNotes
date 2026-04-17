import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quicknotes/presentration/common widget/custom_text_field.dart';
import 'package:quicknotes/presentration/common widget/primary_button.dart';
import 'package:quicknotes/presentration/note/viewmodel/note_viewmodel.dart';

class AddNoteScreen extends HookConsumerWidget {
  const AddNoteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());

    final titleController = useTextEditingController();
    final descController = useTextEditingController();

    final isLoading = ref.watch(noteViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Add Note"), centerTitle: true),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              CustomTextField(
                controller: titleController,
                hintText: 'Enter title',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter title";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              CustomTextField(
                hintText: "Enter description",
                controller: descController,
                maxLines: 5,
                minLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter description";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 25),

              PrimaryButton(
                title: isLoading ? "Saving..." : "Save Note",
                onPressed: isLoading
                    ? null
                    : () async {
                        if (formKey.currentState!.validate()) {
                          bool isSuccess = await ref
                              .read(noteViewModelProvider.notifier)
                              .addNote(
                                titleController.text.trim(),
                                descController.text.trim(),
                              );

                          if (isSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Note Added ✅")),
                            );

                            context.pop(); // 🔥 back to notes
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Failed to add note"),
                              ),
                            );
                          }
                        }
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
