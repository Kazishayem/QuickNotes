// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';

// class NotesScreen extends StatefulWidget {
//   const NotesScreen({super.key});

//   @override
//   State<NotesScreen> createState() => _NotesScreenState();
// }

// class _NotesScreenState extends State<NotesScreen> {
//   final List<Map<String, String>> notes = [
//     {
//       "title": "Meeting Notes",
//       "description":
//           "Discuss project timeline and deliverables.Discuss project timeline and deliverables.",
//     },
//     {"title": "Shopping List", "description": "Milk, Bread, Eggs, Fruits"},
//     {
//       "title": "Ideas",
//       "description": "Build a Flutter app with clean architecture.",
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             SizedBox(height: 10.h),

//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     "My Notes",
//                     style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                   ),

//                   IconButton(
//                     icon: const Icon(Icons.logout),
//                     onPressed: () {
//                       context.go('/signin');
//                     },
//                   ),
//                 ],
//               ),
//             ),

//             Expanded(
//               child: notes.isEmpty
//                   ? const Center(
//                       child: Text(
//                         "No notes yet",
//                         style: TextStyle(fontSize: 16),
//                       ),
//                     )
//                   : ListView.builder(
//                       padding: const EdgeInsets.all(16),
//                       itemCount: notes.length,
//                       itemBuilder: (context, index) {
//                         final note = notes[index];

//                         return Container(
//                           margin: const EdgeInsets.only(bottom: 12),
//                           padding: const EdgeInsets.all(14),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(12),
//                             boxShadow: [
//                               BoxShadow(
//                                 blurRadius: 5,
//                                 color: Colors.black.withOpacity(0.05),
//                                 offset: const Offset(0, 2),
//                               ),
//                             ],
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 note["title"]!,
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const SizedBox(height: 6),
//                               Text(
//                                 note["description"]!,
//                                 style: const TextStyle(
//                                   fontSize: 14,
//                                   color: Colors.grey,
//                                 ),
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//             ),
//           ],
//         ),
//       ),

//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           context.push('/add-note');
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quicknotes/presentration/note/viewmodel/note_viewmodel.dart';

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

            // 🔥 Header
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
                    icon: const Icon(Icons.logout),
                    onPressed: () {
                      context.go('/signin');
                    },
                  ),
                ],
              ),
            ),

            // 🔥 Notes List
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
                      final data = docs[index].data() as Map<String, dynamic>;

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
                                color: Colors.grey,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
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
        onPressed: () {
          context.push('/add-note');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
