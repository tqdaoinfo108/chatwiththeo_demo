import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/rendering.dart';

import 'utils/router.dart';

void main() {
  debugPaintSizeEnabled = false;

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
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      routerConfig: router,
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
        debugPrint("On End");
        context.go("/intro");
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
