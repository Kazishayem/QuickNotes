import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quicknotes/presentration/auth/signin/view/signin_screen.dart';
import 'package:quicknotes/presentration/auth/signup/view/signup_screen.dart';
import 'package:quicknotes/presentration/splash/view/splash_screen.dart';

// import '../views/splash_page.dart';
// import '../views/login_page.dart';
// import '../views/register_page.dart';
// import '../views/home_page.dart';
// import '../views/add_note_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(path: '/', builder: (context, state) => const SigninScreen()),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignupScreen(),
      ),
      // GoRoute(
      //   path: '/home',
      //   builder: (context, state) => const HomePage(),
      // ),
      // GoRoute(
      //   path: '/add-note',
      //   builder: (context, state) => const AddNotePage(),
      // ),
    ],
  );
}
