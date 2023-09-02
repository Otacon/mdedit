import 'package:flutter/material.dart';
import 'package:mdedit_api/init_api.dart';
import 'package:mdedit_linux/app_linux.dart';
import 'package:mdedit_linux/router/router_linux.dart';

void main() async {
  await initApi();
  runApp(AppLinux(router: routerLinux));
}