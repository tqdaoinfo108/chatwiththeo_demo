import 'package:chatwiththeo/screens/dashboard_screen.dart';
import 'package:chatwiththeo/screens/login_forget_pass_screen.dart';
import 'package:chatwiththeo/screens/home_screen.dart';
import 'package:chatwiththeo/screens/intro_screen.dart';
import 'package:chatwiththeo/screens/login_detail_screen.dart';
import 'package:chatwiththeo/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../main.dart';
import '../screens/login_register_screen.dart';

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
        final id = state.extra as int;
        return HomeScreen(id);
      },
    ),
    GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
        routes: [
          GoRoute(
            path: 'forgetPass',
            builder: (BuildContext context, GoRouterState state) {
              return const ForgetPassScreen();
            },
          ),
          GoRoute(
            path: 'register',
            builder: (BuildContext context, GoRouterState state) {
              return const LoginRegisterScreen();
            },
          ),
        ]),
    GoRoute(
      path: '/login/detail',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginDetailScreen();
      },
    ),
    GoRoute(
      path: '/intro',
      builder: (BuildContext context, GoRouterState state) {
        return const IntroScreen();
      },
    ),
    GoRoute(
      path: '/dashboard',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardScreen();
      },
    ),
  ],
);
