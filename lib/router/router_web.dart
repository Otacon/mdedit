import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mdedit/generated/l10n.dart';
import 'package:mdedit/home/home.dart';
import 'package:mdedit/home/home_web.dart';


final GoRouter routerWeb = GoRouter(
  routes: [
    GoRoute(
      path: Home.path,
      builder: (BuildContext context, GoRouterState state) {
        return HomeWeb(title: S.current.app_name);
      },
    ),
  ],
);