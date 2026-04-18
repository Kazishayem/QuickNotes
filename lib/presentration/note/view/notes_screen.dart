import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quicknotes/core/constants/color_manager.dart';
import 'package:quicknotes/presentration/note/viewmodel/note_viewmodel.dart';
import 'package:quicknotes/presentration/auth/viewmodel/auth_viewmodel.dart';

class NotesScreen extends HookConsumerWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesAsync = ref.watch(notesProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "My Notes",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),

                  IconButton(
                    icon: Icon(Icons.logout, color: ColorManager.primary),
                    onPressed: () async {
                      await ref.read(authViewModelProvider.notifier).logout();

                      context.go('/signin');
                    },
                  ),
                ],
              ),
            ),

            Expanded(
              child: notesAsync.when(
                data: (snapshot) {
                  final docs = snapshot.docs;

                  if (docs.isEmpty) {
                    return const Center(child: Text("No notes yet"));
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final doc = docs[index];
                      final data = doc.data() as Map<String, dynamic>;

                      return GestureDetector(
                        onTap: () {
                          context.push(
                            '/note-details',
                            extra: {
                              'title': data['title'],
                              'description': data['description'],
                            },
                          );
                        },
                        child: Container(
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
                                data['title'] ?? '',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 6),

                              Text(
                                data['description'] ?? '',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: ColorManager.black,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },

                loading: () => const Center(child: CircularProgressIndicator()),

                error: (e, _) => Center(child: Text("Error: $e")),
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorManager.primary,
        onPressed: () {
          context.push('/add-note');
        },
        child: Icon(Icons.add, color: ColorManager.white),
      ),
    );
  }
}
