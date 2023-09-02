import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:mdedit_api/init_api.dart';
import 'package:mdedit_macos/app_macos.dart';
import 'package:mdedit_macos/router/router_macos.dart';

void main() async {
  await initApi();

  const config = MacosWindowUtilsConfig();
  await config.apply();

  runApp(AppMacOs(router: routerMacos));
}