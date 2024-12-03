import 'package:chatwiththeo/screens/components/app_scaffold.dart';
import 'package:chatwiththeo/services/app_services.dart';
import 'package:chatwiththeo/utils/constant.dart';
import 'package:chatwiththeo/values/app_colors.dart';
import 'package:chatwiththeo/values/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';

import '../utils/function.dart';
import 'components/app_snackbar.dart';
import 'components/app_textfield.dart';
import 'components/button.dart';

// ignore: must_be_immutable
class LoginDetailScreen extends StatefulWidget {
  const LoginDetailScreen({super.key});

  @override
  State<LoginDetailScreen> createState() => _LoginDetailScreenState();
}

class _LoginDetailScreenState extends State<LoginDetailScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var isRemember = false;
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        titlePage: "Đăng nhập",
        hidenPerson: true,
        hidenNotify: true,
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
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  AppTextFormField(
                    controller: emailController,
                    titleText: "Đây là hành trình của",
                    labelText: "Nhập email của bạn",
                    focusNode: emailFocusNode,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      return FuncExt.validateEmail(value ?? "");
                    },
                  ),
                  const SizedBox(height: 10),
                  AppTextFormField(
                    controller: passwordController,
                    titleText: "Chìa khóa của tôi",
                    labelText: "Nhập mật khẩu của bạn",
                    focusNode: passwordFocusNode,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if ((value?.length ?? 0) < 6) {
                        return "Nhập trên 6 ký tự";
                      }
                      return null;
                    },
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
                            fillColor:
                                WidgetStateProperty.resolveWith((states) {
                              if (!states.contains(WidgetState.selected)) {
                                return Colors.grey.shade200;
                              }
                              return AppColors.primaryColor.withOpacity(.3);
                            }),
                            value: isRemember,
                            onChanged: (value) {
                              setState(() {
                                isRemember = value ?? false;
                              });
                            },
                          ),
                          Text("Ghi nhớ",
                              style: AppTheme.titleMedium
                                  .copyWith(color: Colors.grey))
                        ],
                      ),
                      InkWell(
                        onTap: () => context.push("/login/forgetPass"),
                        child: Text("Quên mật khẩu?",
                            style: AppTheme.titleMedium
                                .copyWith(color: AppColors.primaryColor)),
                      )
                    ],
                  ),
                  const SizedBox(height: 30),
                  AppButton("Xác nhận", () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      var response = await AppServices.instance.letLogin(
                          emailController.text, passwordController.text);
                      if (response != null) {
                        GetStorage().write(AppConstant.IS_REMEMBER, isRemember);
                        GetStorage().write(AppConstant.USER_IMAGEPATH,
                            response.data!.imagesPaths);
                        GetStorage().write(
                            AppConstant.USER_USER_ID, response.data!.userID);
                        GetStorage().write(
                            AppConstant.USER_USERNAME, response.data!.userName);
                        // ignore: use_build_context_synchronously
                        this.context.go("/dashboard");
                      } else {
                        SnackbarHelper.showSnackBar(
                            "Email hoặc mật khẩu không đúng",
                            isError: true);
                      }
                    }
                  }),
                  const SizedBox(height: 50),
                  SvgPicture.asset("assets/logo_mix.svg")
                ],
              ),
            ),
          ),
        ));
  }
}
