import 'package:flutter/material.dart';

import '../values/app_colors.dart';
import 'components/app_scaffold.dart';
import 'components/app_textfield.dart';
import 'components/button.dart';

class LoginRegisterScreen extends StatelessWidget {
  const LoginRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        titlePage: "Đăng ký",
        hidenBackButton: false,
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
          child: SingleChildScrollView(
            child: Column(
              children: [
               const SizedBox(height: 30),
                AppTextFormField(
                  controller: TextEditingController(),
                  titleText: "Họ và tên",
                  labelText: "Nhập họ tên của bạn",
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  onChanged: (_) => {},
                  validator: (value) {},
                ),
                const SizedBox(height: 10),
                AppTextFormField(
                  controller: TextEditingController(),
                  titleText: "Điện thoại",
                  labelText: "Nhập số điện thoại của bạn",
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  onChanged: (_) => {},
                  validator: (value) {},
                ),
                const SizedBox(height: 10),
                AppTextFormField(
                  controller: TextEditingController(),
                  titleText: "Email",
                  labelText: "Nhập đia chỉ email của bạn",
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  onChanged: (_) => {},
                  validator: (value) {},
                ),
                const SizedBox(height: 10),
                AppTextFormField(
                  controller: TextEditingController(),
                  titleText: "Email",
                  labelText: "Lựa chọn của bạn",
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  onChanged: (_) => {},
                  validator: (value) {},
                  suffixIcon: const Icon(Icons.keyboard_arrow_down,
                          color: Colors.black54)
                ),
                const SizedBox(height: 50),
                AppButton("Xác nhận", () {
                }, gradient: AppColors.defaultGradient),
              ],
            ),
          ),
        ));
  }
}
