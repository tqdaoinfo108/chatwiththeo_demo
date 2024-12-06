import 'package:async/async.dart';
import 'package:chatwiththeo/model/categories_model.dart';
import 'package:chatwiththeo/screens/components/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../services/app_services.dart';
import '../utils/constant.dart';
import 'components/home_card.dart';

// ignore: must_be_immutable
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentPageIndex = 0;
  List<CategoryModel> data = [];
  late final Future<AppState> myFuture;

  @override
  void initState() {
    myFuture = initData();
    super.initState();
  }

  Future<AppState> initData() async {
    var response = await AppServices.instance.getCategories(1, 1000);
    if (response != null) {
      setState(() {
        data = response.data!;
      });
    } else {
      Future.value(AppState.ERROR);
    }
    return Future.value(AppState.SUCCESS);
  }

  @override
  Widget build(BuildContext context) {
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
                  return HomeCard(data: data[i]);
                },
                itemCount: data.length),
          )
        ],
      ),
    );

    return FutureBuilder(
        future: myFuture,
        initialData: AppState.LOADING,
        builder: (context, AsyncSnapshot<AppState> snapshot) {
          return snapshot.data == AppState.ERROR
              ? const Center(
                  child: Text("Lỗi"),
                )
              : snapshot.data == AppState.SUCCESS
                  ? AppScaffold(
                      contextSecond: context,
                      titlePage: "Chủ đề",
                      body: homePage,
                      hidenBackButton: true,
                      hidenSearchButton: true,
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    );
        });
  }
}
