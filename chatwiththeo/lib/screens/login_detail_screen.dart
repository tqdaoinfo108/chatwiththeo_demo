import 'package:chatwiththeo/screens/components/app_scaffold.dart';
import 'package:chatwiththeo/values/app_colors.dart';
import 'package:chatwiththeo/values/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'components/app_textfield.dart';
import 'components/button.dart';

// ignore: must_be_immutable
class LoginDetailScreen extends StatelessWidget {
  const LoginDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
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
                labelText: "Nhập số điện thoại của bạn",
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onChanged: (_) => {},
                validator: (value) {},
              ),
              const SizedBox(height: 10),
              AppTextFormField(
                controller: TextEditingController(),
                titleText: "Chìa khóa của tôi",
                labelText: "Nhập mật khẩu của bạn",
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onChanged: (_) => {},
                validator: (value) {},
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.grey,
                        side: const BorderSide(color: Colors.grey),
                        fillColor: WidgetStateProperty.resolveWith((states) {
                          if (!states.contains(WidgetState.selected)) {
                            return Colors.grey.shade200;
                          }
                          return AppColors.primaryColor.withOpacity(.3);
                        }),
                        value: false,
                        onChanged: (value) {},
                      ),
                      Text("Ghi nhớ",
                          style:
                              AppTheme.titleMedium.copyWith(color: Colors.grey))
                    ],
                  ),
                  Text("Quên mật khẩu?",
                      style: AppTheme.titleMedium
                          .copyWith(color: AppColors.primaryColor))
                ],
              ),
              const SizedBox(height: 30),
              AppButton("Xác nhận", () {}),
              const SizedBox(height: 50),
              SvgPicture.asset("assets/logo_mix.svg")
            ],
          ),
        ));
  }
}
