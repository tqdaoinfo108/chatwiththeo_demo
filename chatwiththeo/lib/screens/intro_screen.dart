import 'package:chatwiththeo/main.dart';
import 'package:chatwiththeo/values/app_colors.dart';
import 'package:chatwiththeo/values/app_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';

import '../utils/constant.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with TickerProviderStateMixin {
  late PageController _pageViewController;
  late TabController _tabController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/bg/bg.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          PageView(
            /// [PageView.scrollDirection] defaults to [Axis.horizontal].
            /// Use [Axis.vertical] to scroll vertically.
            controller: _pageViewController,
            onPageChanged: _handlePageViewChanged,
            children: <Widget>[
              Column(
                children: [
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Image.asset("assets/cover/intro3.png"),
                  ),
                  RichText(
                    text: TextSpan(
                      style: AppTheme.titleLarge.copyWith(color: Colors.black),
                      children: <TextSpan>[
                        const TextSpan(
                            text: 'Hễ điều gì không ',
                            style: TextStyle(fontWeight: FontWeight.w300)),
                        TextSpan(
                            text: ' ĐO LƯỜNG!\n',
                            style: AppTheme.titleLarge.copyWith(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold)),
                        const TextSpan(text: 'được thì không quản lý được.')
                      ],
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  const SizedBox(height: 40),
                  Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width - 100,
                        maxHeight: MediaQuery.of(context).size.height / 2.3),
                    child: Image.asset("assets/cover/intro2.png",
                        fit: BoxFit.contain),
                  ),
                  const SizedBox(height: 50),
                  RichText(
                    text: TextSpan(
                      style: AppTheme.titleLarge.copyWith(color: Colors.black),
                      children: <TextSpan>[
                        const TextSpan(
                            text: 'Không quản lý được thì không\n',
                            style: TextStyle(fontWeight: FontWeight.w300)),
                        TextSpan(
                            text: 'PHÁT TRIỂN ĐƯỢC',
                            style: AppTheme.titleLarge.copyWith(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  const SizedBox(height: 40),
                  Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width - 100,
                        maxHeight: MediaQuery.of(context).size.height / 2.5),
                    child: Image.asset("assets/cover/intro4.png",
                        fit: BoxFit.contain),
                  ),
                  const SizedBox(height: 50),
                  RichText(
                    text: TextSpan(
                      style: AppTheme.titleLarge.copyWith(color: Colors.black),
                      children: const <TextSpan>[
                        TextSpan(
                            text: 'Cảm ơn Bạn đã chọn',
                            style: TextStyle(fontWeight: FontWeight.w300)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  SvgPicture.asset("assets/logo_mix.svg"),
                ],
              ),
            ],
          ),
          PageIndicator(
            tabController: _tabController,
            currentPageIndex: _currentPageIndex,
            onUpdateCurrentPageIndex: _updateCurrentPageIndex,
            isOnDesktopAndWeb: true,
          ),
        ],
      ),
    );
  }

  void _handlePageViewChanged(int currentPageIndex) {
    _tabController.index = currentPageIndex;
    setState(() {
      _currentPageIndex = currentPageIndex;
    });
  }

  void _updateCurrentPageIndex(int index) {
    _tabController.index = index;
    _pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
}

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    super.key,
    required this.tabController,
    required this.currentPageIndex,
    required this.onUpdateCurrentPageIndex,
    required this.isOnDesktopAndWeb,
  });

  final int currentPageIndex;
  final TabController tabController;
  final void Function(int) onUpdateCurrentPageIndex;
  final bool isOnDesktopAndWeb;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TabPageSelector(
            controller: tabController,
            color: Colors.white,
            selectedColor: AppColors.primaryColor,
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RawMaterialButton(
                onPressed: () {
                  if (currentPageIndex == 0) {
                    return;
                  }
                  onUpdateCurrentPageIndex(currentPageIndex - 1);
                },
                elevation: 2.0,
                fillColor: AppColors.primaryColor,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: 40),
              RawMaterialButton(
                onPressed: () {
                  if (currentPageIndex == 2) {
                    GetStorage().write(AppConstant.IS_INTRO, true);
                    context.push('/login');
                    return;
                  }
                  onUpdateCurrentPageIndex(currentPageIndex + 1);
                },
                elevation: 2.0,
                fillColor: AppColors.primaryColor,
                padding: const EdgeInsets.all(8),
                shape: const CircleBorder(),
                child: const Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
