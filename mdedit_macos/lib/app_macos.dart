import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:macos_ui/macos_ui.dart';

class AppMacOs extends StatelessWidget {
  final GoRouter router;

  const AppMacOs({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return MacosApp.router(
      routerConfig: router,
      theme: MacosThemeData.light(),
      darkTheme: MacosThemeData.dark(),
      themeMode: ThemeMode.system,
    );
  }
}
