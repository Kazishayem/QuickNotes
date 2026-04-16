import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// import '../views/splash_page.dart';
// import '../views/login_page.dart';
// import '../views/register_page.dart';
// import '../views/home_page.dart';
// import '../views/add_note_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      // GoRoute(
      //   path: '/',
      //   builder: (context, state) => const SplashPage(),
      // ),
      // GoRoute(
      //   path: '/login',
      //   builder: (context, state) => const LoginPage(),
      // ),
      // GoRoute(
      //   path: '/register',
      //   builder: (context, state) => const RegisterPage(),
      // ),
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
