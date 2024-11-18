import 'package:chatwiththeo/screens/home_screen.dart';
import 'package:chatwiththeo/screens/login_detail_screen.dart';
import 'package:chatwiththeo/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../main.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MainApp();
      },
    ),
    GoRoute(
      path: '/home',
      builder: (BuildContext context, GoRouterState state) {
        return HomeScreen();
      },
    ),
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
      path: '/login/detail',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginDetailScreen();
      },
    ),
  ],
);
