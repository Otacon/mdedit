import 'package:adwaita/adwaita.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppLinux extends StatelessWidget {
  final GoRouter router;
  final String? title;

  const AppLinux({super.key, required this.router, this.title});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: title ?? "",
      routerConfig: router,
      theme: AdwaitaThemeData.light(),
      darkTheme: AdwaitaThemeData.dark(),
      themeMode: ThemeMode.system,
    );
  }
}
