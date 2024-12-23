import 'package:chatwiththeo/screens/components/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

import '../model/base_response.dart';
import '../model/position_model.dart';
import '../model/user_model.dart';
import '../services/app_services.dart';
import '../utils/function.dart';
import '../values/app_colors.dart';
import 'components/app_scaffold.dart';
import 'components/app_textfield.dart';
import 'components/button.dart';

class HomeProfileUpdateScreen extends StatefulWidget {
  const HomeProfileUpdateScreen({super.key});

  @override
  State<HomeProfileUpdateScreen> createState() =>
      _HomeProfileUpdateScreenState();
}

class _HomeProfileUpdateScreenState extends State<HomeProfileUpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  List<PositionModel> listPosition = [];
  late UserModel user;

  late PositionModel selectedModel;
  @override
  void initState() {
    initData();
    super.initState();
  }

  initData() async {
    var response = await AppServices.instance.getListPosition();
    if (response != null) {
      setState(() {
        listPosition = response.data ?? [];
      });
    }

    var reponseUSer = await AppServices.instance.getProfile();
    if (reponseUSer != null) {
      user = reponseUSer.data!;
      setState(() {
        emailController.text = user.email!;
        fullNameController.text = user.fullName!;
        addressController.text = user.address!;
        phoneController.text = user.phone!;
        selectedModel =
            listPosition.firstWhere((x) => x.positionID == user.typeUserID);
      });
    }
  }

  Future<ResponseBase<UserModel>?> onUpdate() async {
    var res = await AppServices.instance.letUpdateUser(user.toJsonUpdate(
        fullNameController.text,
        addressController.text,
        phoneController.text,
        emailController.text,
        selectedModel.positionID!));
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      titlePage: 'Cập nhật thông tin',
      contextSecond: context,
      hidenBackButton: false,
      hidenPerson: true,
      hidenNotify: true,
      isShowUpdatePerson: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                AppTextFormField(
                  controller: fullNameController,
                  titleText: "Họ và tên",
                  labelText: "Nhập họ tên của bạn",
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Không được bỏ rỗng";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                AppTextFormField(
                  controller: emailController,
                  titleText: "Email",
                  labelText: "Nhập email của bạn",
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    return FuncExt.validateEmail(value ?? "");
                  },
                ),
                const SizedBox(height: 20),
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
                const SizedBox(height: 20),
                AppTextFormField(
                  controller: addressController,
                  titleText: "Địa chỉ",
                  labelText: "Nhập địa chỉ của bạn",
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  onChanged: (_) => {},
                  validator: (value) {
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                AppTextFormField(
                    controller: typeController,
                    titleText: "Anh/Chị là",
                    labelText: "Lựa chọn của bạn",
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    useTextField: false,
                    initData: listPosition.isNotEmpty ? listPosition[0] : null,
                    lisData: listPosition,
                    suffixIcon: const Icon(Icons.keyboard_arrow_down,
                        color: Colors.black54)),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: (MediaQuery.of(context).size.width - 60) / 2,
                      child: AppButton("Quay lại", () {
                        context.pop();
                      }, gradient: AppColors.subDefaultGradient),
                    ),
                    const SizedBox(width: 20),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width - 60) / 2,
                      child: AppButton("Cập nhật", () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          var res = await onUpdate();
                          if (res != null) {
                            SnackbarHelper.showSnackBar("Cập nhật thành công",
                                ToastificationType.success);
                          } else {
                            SnackbarHelper.showSnackBar(
                                "Cập nhật thất bại", ToastificationType.error);
                          }
                        }
                      }),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
