import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:get_it/get_it.dart';
import 'package:mdedit/app/app.dart';
import 'package:mdedit/app/app_linux.dart';
import 'package:mdedit/app/app_macos.dart';
import 'package:mdedit/document_manager/document_manager.dart';
import 'package:mdedit/home/home_view_model.dart';
import 'package:mdedit/router/router_linux.dart';
import 'package:mdedit/router/router_macos.dart';
import 'package:mdedit/router/router_windows.dart';
import 'package:mdedit/toolbar/toolbar_view_model.dart';
import 'package:system_theme/system_theme.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;

import 'app/app_windows.dart';

registerDependencies() {
  _registerManagers();
  _registerViewModels();
  _registerRouters();
  _registerApps();
}

_registerManagers() {
  final i = GetIt.I;
  i.registerSingleton(DocumentManager());
}

_registerViewModels() {
  final i = GetIt.I;
  i.registerFactory(() => HomeViewModel(i.get()));
  i.registerFactory(() => ToolbarViewModel(i.get()));
}

_registerRouters() {
  final i = GetIt.I;

  i.registerFactory(() => routerLinux, instanceName: "router_linux");
  i.registerFactory(() => routerWindows, instanceName: "router_windows");
  i.registerFactory(() => routerMacos, instanceName: "router_macos");
}

_registerApps() {
  final i = GetIt.I;
  i.registerFactoryAsync(() async {
    if (Platform.isLinux) {
      return AppLinux(router: i.get(instanceName: "router_linux"));
    } else if (Platform.isWindows) {
      return _configureWindowsApp();
    } else if (Platform.isMacOS) {
      return AppMacOs(router: i.get(instanceName: "router_macos"));
    } else {
      throw Exception("Unsupported platform");
    }
  });
}

Future<App> _configureWindowsApp() async {
  final i = GetIt.I;
  SystemTheme.accentColor.load();
  await flutter_acrylic.Window.initialize();
  await WindowManager.instance.ensureInitialized();
  const name = "MDEdit";
  windowManager.waitUntilReadyToShow().then((_) async {
    await windowManager.setMinimumSize(const Size(500, 600));
    await windowManager.setTitle("$name - Untitled");
    await windowManager.show();
    i.get<DocumentManager>().docStream.stream.listen((event) async {
      final document = switch (event) {
        ContentChanged() => event.document,
        FileLoaded() => event.document,
      };
      final fileName = document.path?.split(Platform.pathSeparator).last ?? "Untitled";
      final String changedSymbol;
      if (document.hasContentChanged) {
        changedSymbol = "*";
      } else {
        changedSymbol = "";
      }
      final title = "$name - $fileName$changedSymbol";
      await windowManager.setTitle(title);
    });
  });
  return AppWindows(router: i.get(instanceName: "router_windows"));
}
