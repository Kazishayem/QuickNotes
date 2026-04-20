import 'package:go_router/go_router.dart';
import 'package:quicknotes/presentration/auth/signin/view/signin_screen.dart';
import 'package:quicknotes/presentration/auth/signup/view/signup_screen.dart';
import 'package:quicknotes/presentration/note/add%20note/view/addnote_screen.dart';
import 'package:quicknotes/presentration/note/note%20details/view/notedetails_screen.dart';
import 'package:quicknotes/presentration/note/view/notes_screen.dart';
import 'package:quicknotes/presentration/splash/view/splash_screen.dart';

class AppRouter {
  static GoRouter router(String initialLocation) => GoRouter(
    initialLocation: initialLocation,
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(
        path: '/signin',
        builder: (context, state) => const SigninScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(path: '/notes', builder: (context, state) => const NotesScreen()),
      GoRoute(
        path: '/add-note',
        builder: (context, state) => const AddNoteScreen(),
      ),
      GoRoute(
        path: '/note-details',
        builder: (context, state) {
          final data = state.extra;
          if (data is! Map<String, dynamic>) {
            return const NoteDetailsScreen(title: '', description: '');
          }

          return NoteDetailsScreen(
            title: data['title']?.toString() ?? '',
            description: data['description']?.toString() ?? '',
          );
        },
      ),
    ],
  );
}
