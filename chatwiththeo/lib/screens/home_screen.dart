import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:chatwiththeo/model/question_model.dart';
import 'package:chatwiththeo/screens/components/app_scaffold.dart';
import 'package:chatwiththeo/screens/components/app_textfield.dart';
import 'package:chatwiththeo/values/app_colors.dart';
import 'package:chatwiththeo/values/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../model/answer_model.dart';
import '../model/base_response.dart';
import '../services/app_services.dart';
import '../utils/constant.dart';
import 'components/body_bg.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen(this.categoryID, {super.key});

  final int categoryID;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 0;
  var dateTimeNow = DateTime.now();
  List<QuestionModel> listQuestion = [];
  List<QuestionModel> listQuestionAnswer = [];

  late final Future<AppState> myFuture;
  late final Future<AppState> myFuturesocial;

  @override
  void initState() {
    super.initState();
    myFuture = initData();
    myFuturesocial = initDataSocial();
  }

  Future<AppState> initDataSocial() async {
    var response = await AppServices.instance.getListQuestionAnswer(1, 50);
    if (response != null) {
      setState(() {
        listQuestionAnswer = response.data!;
      });
    } else {
      return Future.value(AppState.ERROR);
    }
    return Future.value(AppState.SUCCESS);
  }

  Future<AppState> initData() async {
    var response =
        await AppServices.instance.getListQuestion(1, 50, widget.categoryID);
    if (response != null) {
      setState(() {
        listQuestion = response.data!;
      });
    } else {
      return Future.value(AppState.ERROR);
    }
    return Future.value(AppState.SUCCESS);
  }

  Widget homePage(BuildContext context) {
    return FutureBuilder(
        future: null,
        initialData: AppState.LOADING,
        builder: (context, AsyncSnapshot<AppState> snapshot) {
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Text(
                          "Vuốt trái phải để xem câu hỏi khác hoặc nhấn nút để chọn ngẫu nhiên.",
                          style: AppTheme.bodySmall.copyWith(
                              color: Colors.black54,
                              fontWeight: FontWeight.w100,
                              fontSize: 14),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        initData();
                      },
                      child: Container(
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
                          )),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return QuestionCard(listQuestion[index]);
                  },
                  itemCount: listQuestion.length,
                  itemWidth: MediaQuery.of(context).size.width,
                  itemHeight: 300.0,
                  layout: SwiperLayout.TINDER,
                ),
              )
            ],
          );
        });
  }

  Widget socialPage() => BackgroundBody(
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemBuilder: (c, i) {
                return SocialCardWidget(listQuestionAnswer[i]);
              },
              itemCount: listQuestionAnswer.length,
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
                    child: InkWell(
                      onTap: () async {
                        final result = await showBoardDateTimePicker(
                            context: context,
                            pickerType: DateTimePickerType.datetime,
                            initialDate: DateTime.now(),
                            minimumDate:
                                dateTimeNow.add(const Duration(days: 1)),
                            maximumDate:
                                dateTimeNow.add(const Duration(days: 365)),
                            options: const BoardDateTimeOptions(
                              languages: BoardPickerLanguages(
                                  locale: "vi",
                                  now: "Bây giờ",
                                  tomorrow: "Ngày mai",
                                  yesterday: "Ngày hôm qua",
                                  today: "Hôm nay"),
                              startDayOfWeek: DateTime.monday,
                              pickerFormat: PickerFormat.dmy,
                            ),
                            showDragHandle: true,
                            onChanged: (v) {
                              setState(() {
                                dateTimeNow = v;
                              });
                            },
                            enableDrag: true);

                        if (result != null) {
                          print('result: $result');
                        }
                      },
                      child: AppTextFormField(
                        textInputAction: TextInputAction.none,
                        titleText: "Ngày bắt đầu",
                        labelText: '',
                        keyboardType: TextInputType.none,
                        controller: TextEditingController(
                            text:
                                "${dateTimeNow.day}/${dateTimeNow.month}/${dateTimeNow.year}"),
                        enabled: false,
                        suffixIcon: const Icon(Icons.keyboard_arrow_down,
                            color: Colors.black54),
                      ),
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
                      controller: TextEditingController(
                          text: "${dateTimeNow.hour}:${dateTimeNow.minute}"),
                      enabled: false,
                    ),
                  ),
                ],
              ),
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

    return AppScaffold(
      titlePage: "Chủ đề",
      hidenBackButton: true,
      hidenSearchButton: true,
      hidenPerson: true,
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

class QuestionCard extends StatelessWidget {
  const QuestionCard(
    this.data, {
    super.key,
  });

  final QuestionModel data;
  @override
  Widget build(BuildContext context) {
    void showFullScreenDialog(BuildContext context) async {
      Navigator.of(context).push(MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (BuildContext context) {
          return CardDetailPopup(data: data);
        },
      ));
    }

    return InkWell(
      onTap: () => showFullScreenDialog(context),
      child: Card(
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
              margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data.questionContent ?? "",
                    softWrap: true,
                    maxLines: 6,
                    overflow: TextOverflow.ellipsis,
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
                          Text(data.numberLike?.toString() ?? "")
                        ],
                      ),
                      const SizedBox(width: 30),
                      Row(
                        children: [
                          SvgPicture.asset("assets/comment.svg"),
                          const SizedBox(width: 5),
                          Text(data.numberComment?.toString() ?? "")
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CardDetailPopup extends StatefulWidget {
  const CardDetailPopup({
    super.key,
    required this.data,
  });

  final QuestionModel data;

  @override
  State<CardDetailPopup> createState() => _CardDetailPopupState();
}

class _CardDetailPopupState extends State<CardDetailPopup> {
  List<AnswerModel> lstData = [];
  @override
  void initState() {
    super.initState();
    initDate();
  }

  initDate() async {
    var listCmt = await AppServices.instance.getListAnswerModel(1, 10, widget.data.questionID!);
    if (listCmt != null) {
      setState(() {
        lstData = listCmt.data ?? [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AppScaffold(
      hidenPerson: true,
      hidenBackButton: true,
      hidenNotify: true,
      titlePage: '',
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: size.width-40),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Card(
                  color: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Text(
                      widget.data.questionContent ?? '',
                      style: AppTheme.titleLarge.copyWith(
                          color: Colors.black87,
                          fontSize: 18,
                          letterSpacing: .5,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
          constraints: BoxConstraints(minWidth: size.width-40),

                  child: Center(
                    child: Card(
                        color: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Column(
                          children: [
                            for (var item in lstData)
                              Container(
          constraints: BoxConstraints(minWidth: size.width-40),

                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: const Color(0xffF4F4F4),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10.0)),
                                      border: Border.all(
                                          color:
                                              const Color(0xff000000).withOpacity(.1),
                                          width: 1)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                          "${item.fullName ?? ''} - ${timeago.format(item.dateCreated ?? DateTime.now())}",
                                          style: AppTheme.bodySmall
                                              .copyWith(color: Colors.black54),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Text(
                                          item.answerContent ?? '',
                                          style: AppTheme.bodySmall
                                              .copyWith(color: Colors.black54),
                                        ),
                                      )
                                    ],
                                  ))
                          ],
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SocialCardWidget extends StatelessWidget {
  const SocialCardWidget(
    this.data, {
    super.key,
  });
  final QuestionModel data;
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
                  data.questionContent ?? '',
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
                        Row(
                          children: [
                            SvgPicture.asset("assets/favorite.svg"),
                            const SizedBox(width: 5),
                            Text("${data.numberLike}")
                          ],
                        ),
                        const SizedBox(width: 30),
                        Row(
                          children: [
                            SvgPicture.asset("assets/comment.svg"),
                            const SizedBox(width: 5),
                            Text("${data.numberComment}")
                          ],
                        )
                      ],
                    ),
                    const Spacer(),
                    Text(
                      timeago
                          .format(data.answer?.dateCreated ?? DateTime.now()),
                      style: AppTheme.bodySmall.copyWith(color: Colors.black54),
                    ),
                  ],
                ),
              ),
              data.answer == null
                  ? const SizedBox(height: 10)
                  : Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
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
                              "${data.answer?.userCreated ?? ''} - ${timeago.format(data.answer?.dateCreated ?? DateTime.now())}",
                              style: AppTheme.bodySmall
                                  .copyWith(color: Colors.black54),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              data.answer?.answerContent ?? '',
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
