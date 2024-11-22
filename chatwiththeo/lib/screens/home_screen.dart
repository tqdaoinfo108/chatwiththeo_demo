import 'package:card_swiper/card_swiper.dart';
import 'package:chatwiththeo/screens/components/app_scaffold.dart';
import 'package:chatwiththeo/screens/components/app_textfield.dart';
import 'package:chatwiththeo/values/app_colors.dart';
import 'package:chatwiththeo/values/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'components/body_bg.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 0;

  Widget homePage(BuildContext context) {
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
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    "Vuốt trái phải để xem câu hỏi khác hoặc nhấn nút để chọn ngẫu nhiên.",
                    style: AppTheme.bodySmall.copyWith(
                        color: Colors.black54,
                        fontWeight: FontWeight.w100,
                        fontSize: 14),
                  ),
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
        SingleChildScrollView(
          child: Swiper(
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
                                  const SizedBox(width: 5),
                                  const Text("245")
                                ],
                              ),
                              const SizedBox(width: 30),
                              Row(
                                children: [
                                  SvgPicture.asset("assets/comment.svg"),
                                  const SizedBox(width: 5),
                                  const Text("245")
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
            itemCount: 2,
            itemWidth: MediaQuery.of(context).size.width,
            itemHeight: 300.0,
            layout: SwiperLayout.TINDER,
          ),
        )
      ],
    );
  }

  Widget bookCalendar() => BackgroundBody(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              "Bạn muốn đặt lịch",
              style: AppTheme.titleLarge
                  .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Flexible(
                  flex: 6,
                  child: AppTextFormField(
                    textInputAction: TextInputAction.none,
                    titleText: "Ngày bắt đầu",
                    labelText: '',
                    keyboardType: TextInputType.none,
                    controller: TextEditingController(text: "08/10/2024"),
                    enabled: false,
                    suffixIcon: const Icon(Icons.keyboard_arrow_down,
                        color: Colors.black54),
                  ),
                ),
                const Spacer(),
                Flexible(
                  flex: 4,
                  child: AppTextFormField(
                    textInputAction: TextInputAction.none,
                    titleText: "",
                    labelText: '',
                    keyboardType: TextInputType.none,
                    controller: TextEditingController(text: "10:00"),
                    enabled: false,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Flexible(
                  flex: 6,
                  child: AppTextFormField(
                    textInputAction: TextInputAction.none,
                    titleText: "Ngày kết thúc",
                    labelText: '',
                    keyboardType: TextInputType.none,
                    controller: TextEditingController(text: "08/10/2024"),
                    enabled: false,
                    suffixIcon: const Icon(Icons.keyboard_arrow_down,
                        color: Colors.black54),
                  ),
                ),
                const Spacer(),
                Flexible(
                  flex: 4,
                  child: AppTextFormField(
                    textInputAction: TextInputAction.none,
                    titleText: "",
                    labelText: '',
                    keyboardType: TextInputType.none,
                    controller: TextEditingController(text: "10:00"),
                    enabled: false,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(color: Colors.black38),
            const SizedBox(height: 10),
            Text(
              "Mô tả nội dung",
              style: AppTheme.titleLarge
                  .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            AppTextFormField(
              textInputAction: TextInputAction.none,
              titleText: "",
              labelText: '',
              keyboardType: TextInputType.none,
              minLines: 4,
              controller: TextEditingController(text: "abc"),
            ),
          ],
        ),
      );

  Widget socialPage() => BackgroundBody(
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 20),
          Text(
            "Hôm nay, 22-10-2024",
            style: AppTheme.bodySmall.copyWith(color: Colors.black54),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemBuilder: (c, i) {
                return SocialCardWidget();
              },
              itemCount: 20,
            ),
          )
        ]),
      );

  Widget profilePage() => BackgroundBody(
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 20),
          Text(
            "Hôm nay, 22-10-2024",
            style: AppTheme.bodySmall.copyWith(color: Colors.black54),
          ),
          const SizedBox(height: 10),
         
        ]),
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
      hidenBackButton: true,
      hidenSearchButton: true,
      body: [
        homePage(context),
        bookCalendar(),
        socialPage(),
        profilePage(),
      ][currentPageIndex],
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

class SocialCardWidget extends StatelessWidget {
  const SocialCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 1,
              blurRadius: 6,
              offset: Offset.zero, // changes position of shadow
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          border: Border.all(
              color: const Color(0xff000000).withOpacity(.1), width: 1)),
      child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Giống như một cái Cây cần phải lớn lên mỗi ngày, nếu không cái cây sẽ chết. Con Người chúng ta cũng vậy!",
                        style: AppTheme.bodySmall
                            .copyWith(color: Colors.black, fontSize: 16),
                      ),
                    ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset("assets/favorite.svg"),
                        const SizedBox(width: 5),
                        const Text("245")
                      ],
                    ),
                    const SizedBox(width: 30),
                    Row(
                      children: [
                        SvgPicture.asset("assets/comment.svg"),
                        const SizedBox(width: 5),
                        const Text("245")
                      ],
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: const Color(0xffF4F4F4),
                   
                    borderRadius:
                        const BorderRadius.all(Radius.circular(10.0)),
                    border: Border.all(
                        color: const Color(0xff000000).withOpacity(.1),
                        width: 1)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Danvu - 20-10-2024 - 02 giờ trước",
                        style: AppTheme.bodySmall
                            .copyWith(color: Colors.black54),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Vuốt để xem câu hỏi khác hoặc nhấn nút để chọn ngẫu nhiên.",
                        style: AppTheme.bodySmall
                            .copyWith(color: Colors.black54),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
