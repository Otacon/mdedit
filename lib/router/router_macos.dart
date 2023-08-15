import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:mdedit/generated/l10n.dart';
import 'package:mdedit/home/home.dart';
import 'package:mdedit/home/home_macos.dart';

final GoRouter routerMacos = GoRouter(
  routes: [
    GoRoute(
      path: Home.path,
      builder: (BuildContext context, GoRouterState state) {
        return HomeMacos(title: S.current.app_name);
      },
    ),
  ],
);
