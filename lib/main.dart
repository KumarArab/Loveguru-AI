import 'package:flutter/material.dart';
import 'package:loveguru_ai/business/router/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'LoveGuru AI',
      theme: ThemeData(
        buttonTheme: const ButtonThemeData(height: 60, minWidth: double.maxFinite),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        primaryColor: Colors.black,
        useMaterial3: true,
      ),
      routerConfig: AppRouter.router,
    );
  }
}
