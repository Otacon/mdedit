import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mdedit/app/app.dart';

class AppWeb extends App {
  final GoRouter router;

  const AppWeb({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
    routerConfig: router,
    theme: ThemeData.light(useMaterial3: true),
    darkTheme: ThemeData.dark(useMaterial3: true),
    themeMode: ThemeMode.system,
    );
  }

}