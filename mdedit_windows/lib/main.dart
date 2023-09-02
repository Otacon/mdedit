import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:mdedit_api/init_api.dart';
import 'package:mdedit_windows/app_windows.dart';
import 'package:mdedit_windows/router/router_windows.dart';
import 'package:flutter/widgets.dart';
import 'package:system_theme/system_theme.dart';

void main() async {
  await initApi();

  SystemTheme.accentColor.load();
  await Window.initialize();
  await Window.setEffect(
    effect: WindowEffect.acrylic,
  );

  runApp(AppWindows(router: routerWindows));
}
