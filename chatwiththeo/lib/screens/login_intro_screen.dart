import 'package:chatwiththeo/screens/components/app_snackbar.dart';
import 'package:chatwiththeo/values/app_colors.dart';
import 'package:chatwiththeo/values/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gallery_picker/gallery_picker.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

import '../utils/constant.dart';
import 'components/button.dart';

class LoginIntroScreen extends StatefulWidget {
  const LoginIntroScreen({super.key});

  @override
  State<LoginIntroScreen> createState() => _LoginIntroScreenState();
}

class _LoginIntroScreenState extends State<LoginIntroScreen> {
  onPickFile() async {
    List<MediaFile>? media = await GalleryPicker.pickMedia(context: context);

    SnackbarHelper.showSnackBar("Huỷ chọn file", ToastificationType.warning);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var imagePath = GetStorage().read(AppConstant.USER_IMAGEPATH) as String?;
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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/logo_mix.svg"),
            const SizedBox(height: 30),
            InkWell(
              onTap: () async {
                await onPickFile();
              },
              child: CircleAvatar(
                backgroundColor: const Color(0xffDB4A2B),
                radius: MediaQuery.of(context).size.width / 4 + 5,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: MediaQuery.of(context).size.width / 4,
                  backgroundImage: AssetImage("assets/user.jpg"),
                ),
              ),
            ),
            const SizedBox(height: 30),
            RichText(
              text: TextSpan(
                text: '',
                children: <TextSpan>[
                  TextSpan(
                      text: 'Chào mừng ',
                      style: AppTheme.titleMedium18.copyWith(fontSize: 18)),
                  TextSpan(
                      text: "${GetStorage().read(AppConstant.USER_FULLNAME)}",
                      style: AppTheme.titleMedium18.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                          fontSize: 18)),
                  TextSpan(
                      text: ' đã đến',
                      style: AppTheme.titleMedium18.copyWith(fontSize: 18)),
                ],
              ),
            ),
            Text(
              "HÀNH TRÌNH PHÁT TRIỂN BẢN THÂN.",
              style: AppTheme.titleMedium18.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                  fontSize: 18),
            ),
            const SizedBox(height: 30),
            AppButton("Bắt đầu", () {
              context.push("/dashboard");
            }),
          ],
        ),
      ),
    );
  }
}
