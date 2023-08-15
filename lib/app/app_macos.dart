import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:mdedit/app/app.dart';

class AppMacOs extends App {
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
