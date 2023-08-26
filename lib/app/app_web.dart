import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mdedit/app/app.dart';

class AppWeb extends App {
  final GoRouter router;
  final String? title;

  const AppWeb({super.key, required this.router, this.title});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: title ?? "",
      routerConfig: router,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
    );
  }
}
