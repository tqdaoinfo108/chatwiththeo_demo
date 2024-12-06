import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../values/app_colors.dart';
import 'components/app_scaffold.dart';
import 'components/app_textfield.dart';
import 'components/button.dart';

class ForgetPassScreen extends StatelessWidget {
  const ForgetPassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      contextSecond: context,
        titlePage: "Đăng nhập",
        body: Container(
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.symmetric(horizontal: 30),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0),
              topLeft: Radius.circular(20.0),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 30),
              AppTextFormField(
                controller: TextEditingController(),
                titleText: "Đây là hành trình của",
                labelText: "Nhập email của bạn",
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onChanged: (_) => {},
                validator: (value) {},
              ),
              const SizedBox(height: 20),
              AppButton("Gửi mã xác nhận", () {
                context.push("/home");
              }),
              const SizedBox(height: 50),
              SvgPicture.asset("assets/logo_mix.svg"),
              const SizedBox(height: 50),
              AppButton("Đăng nhập", () {
              }, gradient: AppColors.subDefaultGradient),
            ],
          ),
        ));
  }
}
