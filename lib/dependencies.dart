import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:mdedit/app/app_linux.dart';
import 'package:mdedit/app/app_macos.dart';
import 'package:mdedit/home/home_view_model.dart';
import 'package:mdedit/router/router_linux.dart';
import 'package:mdedit/router/router_macos.dart';
import 'package:mdedit/router/router_windows.dart';

import 'app/app_windows.dart';

void registerDependencies() {
  registerViewModels();
  registerRouters();
  registerApps();
}

void registerViewModels() {
  final i = GetIt.I;
  i.registerFactory(() => HomeViewModel());
}

void registerRouters() {
  final i = GetIt.I;

  i.registerFactory(() => routerLinux, instanceName: "router_linux");
  i.registerFactory(() => routerWindows, instanceName: "router_windows");
  i.registerFactory(() => routerMacos, instanceName: "router_macos");
}

void registerApps() {
  final i = GetIt.I;

  i.registerFactory(() {
    if (Platform.isLinux) {
      return AppLinux(router: i.get(instanceName: "router_linux"));
    } else if (Platform.isWindows) {
      return AppWindows(router: i.get(instanceName: "router_windows"));
    } else if (Platform.isMacOS) {
      return AppMacOs(router: i.get(instanceName: "router_macos"));
    } else {
      throw Exception("Unsupported platform");
    }
  });
}
