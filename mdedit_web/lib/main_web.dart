import 'package:flutter/material.dart';
import 'package:mdedit_api/init_api.dart';
import 'package:mdedit_web/app_web.dart';
import 'package:mdedit_web/router/router_web.dart';

void main() async {
  await initApi();
  runApp(AppWeb(router: routerWeb));
}