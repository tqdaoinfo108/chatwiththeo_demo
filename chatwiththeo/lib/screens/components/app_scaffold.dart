import 'package:chatwiththeo/values/app_colors.dart';
import 'package:chatwiththeo/values/app_theme.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppScaffold extends StatelessWidget {
  AppScaffold(
      {super.key,
      required this.titlePage,
      required this.body,
      this.bottomNavigationBar,
      this.actions});
  String titlePage;
  Widget body;
  Widget? bottomNavigationBar;
  List<Widget>? actions;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg/bg.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
            bottom: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  leadingWidth: 70,
                  leading: Container(
                    margin: const EdgeInsets.only(left: 30),
                    child: const Card(
                      shape: CircleBorder(),
                      color: AppColors.subColor,
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  actions: actions,
                  title: Text(titlePage,
                      style: AppTheme.titleLarge
                          .copyWith(color: AppColors.subColor)),
                  centerTitle: false,
                ),
                Expanded(
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width, child: body),
                ),
              ],
            )),
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
