import 'package:chatwiththeo/screens/components/app_scaffold.dart';
import 'package:chatwiththeo/services/app_services.dart';
import 'package:chatwiththeo/values/app_colors.dart';
import 'package:flutter/material.dart';

import '../model/schedule_model.dart';
import '../values/app_theme.dart';
import 'components/body_bg.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with TickerProviderStateMixin {
  bool isLoading = true;
  List<ScheduleModel> listData = [];
  getListSchedule() async {
    var result = await AppServices.instance.getListSchedule(1, 100);
    if (result != null) {
      setState(() {
        listData = result.data!;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getListSchedule();
  }

  @override
  Widget build(BuildContext context) {
    final tabController = TabController(length: 2, vsync: this);

    return AppScaffold(
      contextSecond: context,
      hidenBackButton: false,
      hidenNotify: true,
      hidenPerson: true,
      titlePage: 'Thông báo',
      body: BackgroundBody(
        paddingHorizontal: 0,
        body: DefaultTabController(
          length: 2,
          initialIndex: 1,
          child: Column(
            children: [
              TabBar(
                dividerHeight: 4,
                padding: const EdgeInsets.symmetric(vertical: 10),
                dividerColor: Colors.grey,
                indicator: UnderlineTabIndicator(
                    borderSide:
                        const BorderSide(width: 4.0, color: AppColors.subColor),
                    insets: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 3)),
                controller: tabController,
                tabs: <Widget>[
                  Tab(
                    child: Text("Thông báo",
                        style: AppTheme.titleMedium18
                            .copyWith(fontWeight: FontWeight.bold)),
                  ),
                  Tab(
                    child: Text("Lịch hẹn",
                        style: AppTheme.titleMedium18
                            .copyWith(fontWeight: FontWeight.bold)),
                  )
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: <Widget>[
                    Center(
                      child: Text(
                        "Tính năng đang phát triển",
                        style: AppTheme.titleMedium18,
                      ),
                    ),
                    listData.isEmpty
                        ? Center(
                            child: Text(
                              "Không có dữ liệu",
                              style: AppTheme.titleMedium18,
                            ),
                          )
                        : ListView.builder(
                            itemCount: listData.length,
                            itemBuilder: (c, i) {
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: const Color(0xffF4F4F4),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0)),
                                    border: Border.all(
                                        color: const Color(0xff000000)
                                            .withOpacity(.1),
                                        width: 1)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        listData[i].dateSchedule ?? "",
                                        style: AppTheme.bodySmall
                                            .copyWith(color: Colors.black54),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Text(
                                        listData[i].description ?? "",
                                        style: AppTheme.bodySmall
                                            .copyWith(color: Colors.black54),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            })
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
