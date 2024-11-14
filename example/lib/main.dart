import 'dart:ui';

import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:chatwiththeo/screens/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

import 'screens/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
      DevicePreview(
        enabled: true,
        builder: (context) => const MyApp(), // Wrap your app
      ),
    );
} 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
      gradient: const RadialGradient(
        colors: [
          Color(0xFFe5e9ec),
          Color(0xFFa3b2b9),
        ],
        center: const FractionalOffset(0.0, 0.0),
      ),
      onInit: () {
        debugPrint("On Init");
      },
      onEnd: () {
        debugPrint("On End");
      },
      childWidget: ShaderMask(
          shaderCallback: (bounds) {
            return const RadialGradient(
              colors: [Colors.transparent, Colors.transparent, Colors.white],
              stops: [0.0, 0.5, 1.0],
            ).createShader(bounds);
          },
          blendMode: BlendMode.dstOut, // Loại bỏ gradient
          child: Image.asset("assets/spashscreen.png")),
      onAnimationEnd: () => debugPrint("On Fade In End"),
      nextScreen: const LoginPage(),
      // nextScreen: const HomePage(),
    );
  }
}
