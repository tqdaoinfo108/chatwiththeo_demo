import 'package:flutter/material.dart';

import '../../values/app_colors.dart';
import '../../values/app_theme.dart';

// ignore: must_be_immutable
class AppButton extends StatelessWidget {
  AppButton(this.title, this.onPress,
      {super.key, this.gradient = AppColors.defaultGradient});
  String title;
  Function onPress;
  List<Color>? gradient;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 52,
        width: double.infinity,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: AppColors.defaultGradient,
            ),
          ),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                overlayColor: Colors.transparent,
                shadowColor: Colors.transparent,
              ),
              child: Text(title, style: AppTheme.titleMedium),
              onPressed: () {}),
        ));
  }
}
