import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:mdedit_api/generated/l10n.dart';
import 'package:mdedit_windows/home/home_windows.dart';

final GoRouter routerWindows = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (BuildContext context, GoRouterState state) {
        return HomeWindows(title: S.current.app_name);
      },
    ),
  ],
);
