import 'package:chatwiththeo/model/question_model.dart';
import 'package:chatwiththeo/screens/dashboard_screen.dart';
import 'package:chatwiththeo/screens/login_forget_pass_screen.dart';
import 'package:chatwiththeo/screens/home_screen.dart';
import 'package:chatwiththeo/screens/intro_screen.dart';
import 'package:chatwiththeo/screens/login_detail_screen.dart';
import 'package:chatwiththeo/screens/login_screen.dart';
import 'package:chatwiththeo/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';

import '../main.dart';
import '../screens/login_intro_screen.dart';
import '../screens/login_register_screen.dart';
import '../screens/notification_screen.dart';
import '../screens/question_detail_screen.dart';

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
          GoRoute(
            path: 'intro',
            builder: (BuildContext context, GoRouterState state) {
              return const LoginIntroScreen();
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
    GoRoute(
      path: '/question_detail',
      builder: (BuildContext context, GoRouterState state) {
        var model =
            QuestionModel.fromJson(GetStorage().read(AppConstant.QUESTION_ID));
        return QuestionDetailScreen(data: model);
      },
    ),
    GoRoute(
      path: '/notification',
      builder: (BuildContext context, GoRouterState state) {
        return const NotificationScreen();
      },
    ),
  ],
);
