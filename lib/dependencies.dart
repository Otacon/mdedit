import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:mdedit/app/app.dart';
import 'package:mdedit/app/app_linux.dart';
import 'package:mdedit/app/app_macos.dart';
import 'package:mdedit/app/app_windows.dart';
import 'package:mdedit/document_manager/document_manager.dart';
import 'package:mdedit/home/home_view_model.dart';
import 'package:mdedit/router/router_linux.dart';
import 'package:mdedit/router/router_macos.dart';
import 'package:mdedit/router/router_windows.dart';
import 'package:system_theme/system_theme.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;

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
    if (kIsWeb) {
      return _configureWebApp();
    } else if (Platform.isLinux) {
      return _configureLinuxApp();
    } else if (Platform.isWindows) {
      return _configureWindowsApp();
    } else if (Platform.isMacOS) {
      return _configureMacosApp();
    } else {
      throw Exception("Unsupported platform");
    }
  });
}

Future<App> _configureWebApp() async {
  final i = GetIt.I;
  return AppLinux(router: i.get(instanceName: "router_linux"));
}

Future<App> _configureLinuxApp() async {
  final i = GetIt.I;
  _attachToWindowManager();
  return AppLinux(router: i.get(instanceName: "router_linux"));
}

Future<App> _configureWindowsApp() async {
  final i = GetIt.I;
  SystemTheme.accentColor.load();
  await flutter_acrylic.Window.initialize();
  await flutter_acrylic.Window.setEffect(
    effect: flutter_acrylic.WindowEffect.acrylic,
  );
  _attachToWindowManager();
  return AppWindows(router: i.get(instanceName: "router_windows"));
}

Future<App> _configureMacosApp() async {
  const config = MacosWindowUtilsConfig();
  await config.apply();
  final i = GetIt.I;
  _attachToWindowManager();
  return AppMacOs(router: i.get(instanceName: "router_macos"));
}

_attachToWindowManager() async {
  final i = GetIt.I;
  await WindowManager.instance.ensureInitialized();
  const name = "MDEdit";
  windowManager.waitUntilReadyToShow().then((_) async {
    await windowManager.setMinimumSize(const Size(500, 600));
    await windowManager.setTitle("$name - Untitled");
    await windowManager.setPreventClose(true);
    await windowManager.show();
    i.get<DocumentManager>().docStream.stream.listen((event) async {
      final document = switch (event) {
        ContentChanged() => event.document,
        FileLoaded() => event.document,
      };
      final fileName =
          document.path?.split(Platform.pathSeparator).last ?? "Untitled";
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
}
