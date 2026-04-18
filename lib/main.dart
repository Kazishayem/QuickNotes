import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quicknotes/core/routes/app_router.dart';
import 'package:quicknotes/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final prefs = await SharedPreferences.getInstance();
  final isFirstTime = prefs.getBool('isFirstTime') ?? true;
  final user = FirebaseAuth.instance.currentUser;
  final initialLocation = isFirstTime
      ? '/'
      : (user != null ? '/notes' : '/signin');
  runApp(
    ProviderScope(
      child: MyApp(initialLocation: initialLocation),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String initialLocation;
  const MyApp({super.key, required this.initialLocation});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,                                                                                                                                                                                                                   
      builder: (context, child) {
        return MaterialApp.router(
          routerConfig: AppRouter.router(initialLocation),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
