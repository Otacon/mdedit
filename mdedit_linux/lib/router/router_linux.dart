import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:mdedit_linux/home/home_linux.dart';
import 'package:mdedit_api/generated/l10n.dart';

final GoRouter routerLinux = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (BuildContext context, GoRouterState state) {
        return HomeLinux(title: S.current.app_name);
      },
    ),
  ],
);