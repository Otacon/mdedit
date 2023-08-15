import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:mdedit/app/app.dart';

class AppWindows extends App {
  final GoRouter router;

  const AppWindows({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return FluentApp.router(
      routerConfig: router,
      theme: FluentThemeData.light(),
      darkTheme: FluentThemeData.dark(),
      themeMode: ThemeMode.system,
    );
  }
}
