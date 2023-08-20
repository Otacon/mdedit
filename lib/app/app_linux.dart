import 'package:adwaita/adwaita.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mdedit/app/app.dart';

class AppLinux extends App {
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
