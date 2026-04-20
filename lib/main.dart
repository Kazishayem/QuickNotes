import 'dart:async';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quicknotes/core/constants/color_manager.dart';
import 'package:quicknotes/core/routes/app_router.dart';
import 'package:quicknotes/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      FlutterError.onError = (details) {
        FlutterError.presentError(details);
        Zone.current.handleUncaughtError(
          details.exception,
          details.stack ?? StackTrace.empty,
        );
      };

      PlatformDispatcher.instance.onError = (error, stack) {
        Zone.current.handleUncaughtError(error, stack);
        return true;
      };

      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      final prefs = await SharedPreferences.getInstance();
      final isFirstTime = prefs.getBool('isFirstTime') ?? true;
      final user = FirebaseAuth.instance.currentUser;
      final initialLocation = isFirstTime
          ? '/'
          : (user != null ? '/notes' : '/signin');

      runApp(ProviderScope(child: MyApp(initialLocation: initialLocation)));
    },
    (error, stack) {
      debugPrint('Uncaught app error: $error');
      debugPrintStack(stackTrace: stack);
    },
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
          title: 'QuickNotes',
          theme: ThemeData(
            useMaterial3: true,
            fontFamily: 'Manrope',
            scaffoldBackgroundColor: ColorManager.surface,
            colorScheme: ColorScheme.fromSeed(
              seedColor: ColorManager.primary,
              primary: ColorManager.primary,
              secondary: ColorManager.accent,
              surface: ColorManager.surface,
            ),
            appBarTheme: const AppBarTheme(
              elevation: 0,
              centerTitle: true,
              backgroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              foregroundColor: ColorManager.black,
            ),
            cardTheme: CardThemeData(
              color: ColorManager.card,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
              elevation: 0,
            ),
          ),
          routerConfig: AppRouter.router(initialLocation),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
