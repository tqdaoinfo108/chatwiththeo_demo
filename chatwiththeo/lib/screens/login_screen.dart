import 'dart:math';

import 'package:chatwiththeo/utils/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../values/app_colors.dart';
import 'components/button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: size.width / 12),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg/bg.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            Image.asset("assets/cover/cover.png", fit: BoxFit.fitWidth),
            const SizedBox(height: 20),
            AppButton("Đăng nhập", () {
              context.push("/login/detail");
            }),
            const SizedBox(height: 10),
            AppButton("Đăng ký", () {
              context.push("/login/register");
            }, gradient: AppColors.subDefaultGradient),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
