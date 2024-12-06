import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:chatwiththeo/utils/constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/rendering.dart';
import 'package:toastification/toastification.dart';
import 'model/question_model.dart';
import 'screens/components/app_snackbar.dart';
import 'utils/router.dart';

void main() async {
  debugPaintSizeEnabled = false;
  await GetStorage.init();
  runApp(
    DevicePreview(
      enabled: kIsWeb,
      builder: (context) => const MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: SnackbarHelper.key,
        locale: kIsWeb ? DevicePreview.locale(context) : const Locale("vi"),
        builder: DevicePreview.appBuilder,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        routerConfig: router,
      ),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
      animationDuration: const Duration(seconds: 1),
      backgroundColor: Colors.white,
      onInit: () {
        debugPrint("On Init");
      },
      onEnd: () {
        var nextPage =
            bool.tryParse(GetStorage().read(AppConstant.IS_INTRO).toString());
        var isRemember = bool.tryParse(
            GetStorage().read(AppConstant.IS_REMEMBER).toString());
        if (isRemember != null && !isRemember) {
          GetStorage().remove(AppConstant.USER_USER_ID);
          GetStorage().remove(AppConstant.QUESTION_ID);
        }
        var isUserID = GetStorage().read(AppConstant.IS_REMEMBER);
        var isNextHome = isUserID != null && isUserID != 0;

        var questionExist = GetStorage().read(AppConstant.QUESTION_ID);
        context.go(nextPage == null || !nextPage
            ? "/intro"
            : questionExist != null
                ? "/question_detail"
                : questionExist != null
                    ? "/question_detail"
                    : isNextHome
                        ? "/dashboard"
                        : "/login");
      },
      childWidget: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Image.asset("assets/spashscreen.png"),
          SvgPicture.asset("assets/logo.svg")
        ],
      ),
      onAnimationEnd: () => debugPrint("On Fade In End"),
      // nextScreen: const LoginScreen(),
    );
  }
}
