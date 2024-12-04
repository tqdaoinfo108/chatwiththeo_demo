import 'package:chatwiththeo/values/app_colors.dart';
import 'package:chatwiththeo/values/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';

import '../../utils/constant.dart';

// ignore: must_be_immutable
class AppScaffold extends StatelessWidget {
  AppScaffold(
      {super.key,
      required this.titlePage,
      required this.body,
      this.bottomNavigationBar,
      this.actions,
      this.hidenBackButton,
      this.hidenSearchButton,
      this.hidenPerson,
      this.hidenNotify});

  String titlePage;
  Widget body;
  Widget? bottomNavigationBar;
  List<Widget>? actions;
  final bool? hidenBackButton;
  final bool? hidenSearchButton;
  final bool? hidenPerson;
  final bool? hidenNotify;

  @override
  Widget build(BuildContext context) {
    var image = GetStorage().read(AppConstant.USER_IMAGEPATH);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg/bg.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
            bottom: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                AppBar(
                  backgroundColor: Colors.transparent,
                  leadingWidth: 70,
                  leading: (hidenBackButton ?? true)
                      ? null
                      : InkWell(
                          onTap: () => context.pop(),
                          child: Container(
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
                        ),
                  actions: [
                    ...actions ?? [],
                    (hidenNotify ?? false)
                        ? const SizedBox()
                        : IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.notifications,
                              color: AppColors.subColor,
                            )),
                    const SizedBox(width: 10),
                    (hidenPerson ?? false)
                        ? const SizedBox()
                        : InkWell(
                            onTap: () {
                              context.go("/login");
                              GetStorage().erase();
                            },
                            child: CircleAvatar(
                              radius: 18,
                              child: (image == null || image == '')
                                  ? const Icon(Icons.person)
                                  : Image.network(GetStorage()
                                      .read(AppConstant.USER_IMAGEPATH)),
                            ),
                          ),
                    const SizedBox(width: 10),
                  ],
                  title: (hidenBackButton ?? true)
                      ? null
                      : Text(titlePage,
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
