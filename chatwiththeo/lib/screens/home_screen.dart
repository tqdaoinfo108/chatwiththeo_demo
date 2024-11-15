import 'package:card_swiper/card_swiper.dart';
import 'package:chatwiththeo/screens/components/app_scaffold.dart';
import 'package:chatwiththeo/values/app_colors.dart';
import 'package:chatwiththeo/values/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'components/body_bg.dart';
import 'components/home_card.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HomeCard(type: 1),
            HomeCard(type: 2),
          ],
        ),
        const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HomeCard(type: 3),
            HomeCard(type: 4),
          ],
        )
      ],
    ),
  );

  Widget themePage(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        SvgPicture.asset("assets/logo_mix.svg"),
        const SizedBox(height: 40),
        Container(
          height: 60,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Row(
            children: [
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                      "Vuốt trái phải để xem câu hỏi khác hoặc nhấn nút để chọn ngẫu nhiên."),
                ),
              ),
              Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: const Icon(
                    Icons.refresh_outlined,
                    color: Colors.white,
                  ))
            ],
          ),
        ),
        const SizedBox(height: 20),
        Swiper(
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: -35,
                    right: -20,
                    child: SvgPicture.asset('assets/card_icon.svg'),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Giống như một cái Cây cần phải lớn lên mỗi ngày, nếu không cái cây sẽ chết.Con Người chúng ta cũng vậy!",
                          softWrap: true,
                          style: AppTheme.titleLarge.copyWith(
                              color: Colors.black87,
                              fontSize: 20,
                              letterSpacing: .5,
                              fontWeight: FontWeight.normal),
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset("assets/favorite.svg"),
                                SizedBox(width: 5),
                                Text("245")
                              ],
                            ),
                            SizedBox(width: 30),
                            Row(
                              children: [
                                SvgPicture.asset("assets/comment.svg"),
                                SizedBox(width: 5),
                                Text("245")
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
          itemCount: 10,
          itemWidth: MediaQuery.of(context).size.width,
          itemHeight: 300.0,
          layout: SwiperLayout.TINDER,
        )
      ],
    );
  }

  Widget bookCalendar() => BackgroundBody(
        body: Container(),
      );
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      titlePage: "Chủ đề",
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: AppColors.subColor,
            )),
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
      body: [homePage, themePage(context), bookCalendar()][currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        selectedIconTheme: const IconThemeData(color: Colors.white),
        unselectedItemColor: const Color(0xffCCCCCC),
        unselectedIconTheme: const IconThemeData(color: Color(0xffCCCCCC)),
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.subColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder_special_outlined, color: Colors.white),
            label: 'Chủ đề',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined, color: Colors.white),
            label: 'Đặt lịch',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.interpreter_mode_outlined, color: Colors.white),
            label: 'Cộng đồng',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.white),
            label: 'Hồ sơ',
          ),
        ],
        currentIndex: currentPageIndex,
        onTap: (a) {
          setState(() {
            currentPageIndex = a;
          });
        },
      ),
    );
  }
}
