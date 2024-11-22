import 'package:chatwiththeo/screens/components/app_scaffold.dart';
import 'package:chatwiththeo/values/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'components/home_card.dart';

// ignore: must_be_immutable
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentPageIndex = 0;

  Widget homePage = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        SvgPicture.asset("assets/logo_mix.svg"),
        const SizedBox(height: 20),
        Flexible(
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (c, i) {
                return HomeCard(type: i + 1);
              },
              itemCount: 4),
        )
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      titlePage: "Chủ đề",
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications,
              color: AppColors.subColor,
            )),
        const SizedBox(width: 10),
        const CircleAvatar(
          radius: 18,
          child: Icon(Icons.person_2),
        ),
        const SizedBox(width: 10),
      ],
      body: homePage,
      hidenBackButton: true,
      hidenSearchButton: true,
    );
  }
}
