import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quicknotes/core/constants/color_manager.dart';
import 'package:quicknotes/core/utils/app_snackbar.dart';
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
      appBar: AppBar(title: const Text('New Note')),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: ColorManager.softBackgroundGradient,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x14000000),
                    blurRadius: 16,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Write something important',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Notes are saved instantly to your cloud workspace.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black.withValues(alpha: 0.62),
                      ),
                    ),
                    const SizedBox(height: 18),
                    CustomTextField(
                      controller: titleController,
                      hintText: 'Note title',
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Enter title';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 14),
                    CustomTextField(
                      hintText: 'Write details here...',
                      controller: descController,
                      maxLines: 8,
                      minLines: 8,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Enter description';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    PrimaryButton(
                      title: isLoading ? 'Saving...' : 'Save Note',
                      onPressed: isLoading
                          ? null
                          : () async {
                              if (formKey.currentState!.validate()) {
                                final isSuccess = await ref
                                    .read(noteViewModelProvider.notifier)
                                    .addNote(
                                      titleController.text.trim(),
                                      descController.text.trim(),
                                    );

                                if (!context.mounted) return;
                                if (isSuccess) {
                                  AppSnackbar.show(
                                    context,
                                    message: 'Note saved successfully.',
                                    type: AppSnackbarType.success,
                                  );
                                  context.pop();
                                } else {
                                  AppSnackbar.show(
                                    context,
                                    message: 'Failed to save note.',
                                    type: AppSnackbarType.error,
                                  );
                                }
                              }
                            },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
