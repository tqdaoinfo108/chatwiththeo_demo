import 'package:chatwiththeo/model/position_model.dart';
import 'package:chatwiththeo/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

import '../utils/constant.dart';
import '../utils/function.dart';
import '../values/app_colors.dart';
import 'components/app_scaffold.dart';
import 'components/app_snackbar.dart';
import 'components/app_textfield.dart';
import 'components/button.dart';

class LoginRegisterScreen extends StatefulWidget {
  const LoginRegisterScreen({super.key});

  @override
  State<LoginRegisterScreen> createState() => _LoginRegisterScreenState();
}

class _LoginRegisterScreenState extends State<LoginRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  late PositionModel selectPosition;
  List<PositionModel> listPosition = [];
  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() async {
    var response = await AppServices.instance.getListPosition();
    if (response != null) {
      setState(() {
        listPosition = response.data ?? [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        contextSecond: context,
        titlePage: "Đăng ký",
        hidenBackButton: false,
        hidenNotify: true,
        hidenPerson: true,
        hidenSearchButton: true,
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
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  AppTextFormField(
                    controller: fullNameController,
                    titleText: "Họ và tên",
                    labelText: "Nhập họ tên của bạn",
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if ((value?.length ?? 0) == 0) {
                        return "Không được bỏ trống";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  AppTextFormField(
                    controller: phoneController,
                    titleText: "Điện thoại",
                    labelText: "Nhập số điện thoại của bạn",
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    onChanged: (_) => {},
                    validator: (value) {
                      if ((value?.length ?? 0) != 10) {
                        return "Nhập 10 ký tự";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  AppTextFormField(
                    controller: emailController,
                    titleText: "Email",
                    labelText: "Nhập đia chỉ email của bạn",
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    onChanged: (_) => {},
                    validator: (value) {
                      return FuncExt.validateEmail(value ?? "");
                    },
                  ),
                  const SizedBox(height: 10),
                  AppTextFormField(
                    controller: passwordController,
                    titleText: "Mật khẩu",
                    labelText: "Nhập mật khẩu của bạn",
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    onChanged: (_) => {},
                    validator: (value) {
                      if ((value?.length ?? 0) < 6) {
                        return "Nhập trên 6 ký tự";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  AppTextFormField(
                      controller: typeController,
                      titleText: "Anh/Chị là",
                      labelText: "Lựa chọn của bạn",
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      useTextField: false,
                      initData:
                          listPosition.isNotEmpty ? listPosition[0] : null,
                      lisData: listPosition,
                      suffixIcon: const Icon(Icons.keyboard_arrow_down,
                          color: Colors.black54)),
                  const SizedBox(height: 50),
                  AppButton("Xác nhận", () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      var response = await AppServices.instance.letRegister(
                          emailController.text,
                          passwordController.text,
                          phoneController.text,
                          fullNameController.text,
                          listPosition
                              .firstWhere(
                                  (e) => e.positionName == typeController.text)
                              .positionID!);
                      if (response != null) {
                        GetStorage().write(AppConstant.IS_REMEMBER, true);
                        GetStorage().write(AppConstant.USER_IMAGEPATH,
                            response.data?.imagesPaths ?? '');
                        GetStorage().write(
                            AppConstant.USER_USER_ID, response.data!.userID);
                        GetStorage().write(
                            AppConstant.USER_USERNAME, response.data!.userName);
                        // ignore: use_build_context_synchronously
                        context.go("/login/intro");
                        SnackbarHelper.showSnackBar(
                            "Đăng nhập thành công", ToastificationType.error);
                      } else {
                        SnackbarHelper.showSnackBar(
                            "Lỗi !!!", ToastificationType.error);
                      }
                    }
                  }, gradient: AppColors.defaultGradient),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ));
  }
}
