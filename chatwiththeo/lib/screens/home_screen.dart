import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:chatwiththeo/model/question_model.dart';
import 'package:chatwiththeo/screens/components/app_scaffold.dart';
import 'package:chatwiththeo/screens/components/app_snackbar.dart';
import 'package:chatwiththeo/screens/components/app_textfield.dart';
import 'package:chatwiththeo/values/app_colors.dart';
import 'package:chatwiththeo/values/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';

import '../model/user_model.dart';
import '../services/app_services.dart';
import '../utils/constant.dart';
import 'components/body_bg.dart';
import 'components/button.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen(this.categoryID, {super.key});

  final int categoryID;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 0;
  var dateTimeNow = DateTime.now().add(const Duration(hours: 1));
  List<QuestionModel> listQuestion = [];
  List<QuestionModel> listQuestionAnswer = [];

  UserModel? userModel;

  late final Future<AppState> myFuture;
  late final Future<AppState> myFuturesocial;
  late final Future<AppState> myFutureProfile;

  @override
  void initState() {
    myFuture = initData();
    myFuturesocial = initDataSocial();
    myFutureProfile = initProfile();

    dateController.text =
        "${dateTimeNow.day}/${dateTimeNow.month}/${dateTimeNow.year}";
    timeController.text = "${dateTimeNow.hour}:${dateTimeNow.minute}";
    super.initState();
  }

  Future<AppState> initProfile() async {
    var response = await AppServices.instance.getProfile();
    if (response != null) {
      setState(() {
        userModel = response.data!;
      });
    } else {
      return Future.value(AppState.ERROR);
    }
    return Future.value(AppState.SUCCESS);
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

  Widget profilePage() => userModel == null
      ? const Center(child: CircularProgressIndicator())
      : BackgroundBody(
          paddingHorizontal: 0,
          body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Center(child: SvgPicture.asset("assets/logo_mix.svg")),
                const SizedBox(height: 30),
                Container(
                  color: const Color(0xffE6D9D2),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  child: Row(
                    children: [
                      const SizedBox(width: 20),
                      InkWell(
                        onTap: () {},
                        child: CircleAvatar(
                          radius: 26,
                          child: (GetStorage()
                                          .read(AppConstant.USER_IMAGEPATH) ==
                                      null ||
                                  GetStorage()
                                          .read(AppConstant.USER_IMAGEPATH) ==
                                      '')
                              ? const Icon(Icons.person, size: 26)
                              : Image.network(GetStorage()
                                  .read(AppConstant.USER_IMAGEPATH)),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userModel!.fullName ?? "",
                            style: AppTheme.titleMedium20.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),
                          ),
                          Text(
                            userModel!.phone ?? "",
                            style: AppTheme.titleMedium
                                .copyWith(color: Colors.black54),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Thư điện tử",
                          style: AppTheme.titleMedium18
                              .copyWith(color: Colors.grey)),
                      Text(userModel?.email ?? "",
                          style: AppTheme.titleMedium18),
                      const SizedBox(height: 10),
                      Text("Địa chỉ",
                          style: AppTheme.titleMedium18
                              .copyWith(color: Colors.grey)),
                      Text(userModel?.address ?? "",
                          style: AppTheme.titleMedium18),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
              ]),
        );
  final dateController = TextEditingController();
  final desciptionController = TextEditingController();
  final timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    postCalendar() async {
      var result = await AppServices.instance
          .postInsertSchedule(desciptionController.text, dateTimeNow);
      if (result) {
        SnackbarHelper.showSnackBar("Tạo thành công!");
        setState(() {
          dateTimeNow = DateTime.now().add(const Duration(hours: 1));
          dateController.text =
              "${dateTimeNow.day}/${dateTimeNow.month}/${dateTimeNow.year}";
          timeController.text = "${dateTimeNow.hour}:${dateTimeNow.minute}";
          desciptionController.text = '';
        });
      } else {
        SnackbarHelper.showSnackBar("Tạo thất bại!");
      }
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
                    child: InkWell(
                      onTap: () async {
                        final result = await showBoardDateTimePicker(
                            context: context,
                            pickerType: DateTimePickerType.datetime,
                            initialDate: DateTime.now(),
                            minimumDate:
                                dateTimeNow.add(const Duration(hours: 1)),
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
                          setState(() {
                            dateTimeNow = result;
                          });
                        }
                      },
                      child: AppTextFormField(
                        textInputAction: TextInputAction.none,
                        titleText: "Ngày bắt đầu",
                        labelText: '',
                        keyboardType: TextInputType.none,
                        controller: dateController,
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
                      controller: timeController,
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
                controller: desciptionController,
              ),
              const SizedBox(height: 20),
              AppButton("Xác nhận", () async {
                if (desciptionController.text.length < 20) {
                  SnackbarHelper.showSnackBar("Nội dung ít nhất 20 ký tự");
                } else {
                  await postCalendar();
                }
              }),
            ],
          ),
        );

    return AppScaffold(
      titlePage: "Chủ đề",
      hidenBackButton: false,
      hidenSearchButton: true,
      hidenPerson: currentPageIndex == 3,
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

class QuestionCard extends StatefulWidget {
  const QuestionCard(
    this.data, {
    super.key,
  });

  final QuestionModel data;

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  var commentController = TextEditingController();

  Future<bool> _postComment() async {
    var result = await AppServices.instance
        .postComment(widget.data.questionID!, commentController.text);
    if (result) {
      commentController.text = '';
      SnackbarHelper.showSnackBar("Trả lời thành công");
      return true;
    } else {
      SnackbarHelper.showSnackBar("Trả lời thất bại");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    showComment() async {
      showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.white,
          builder: (BuildContext context) {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 2.7,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      AppTextFormField(
                        textInputAction: TextInputAction.none,
                        titleText: "",
                        labelText:
                            'Câu trả lời của bạn mỗi ngày và không thể xoá',
                        keyboardType: TextInputType.multiline,
                        controller: commentController,
                        enabled: true,
                        minLines: 5,
                      ),
                      const SizedBox(height: 20),
                      AppButton("Xác nhận", () async {
                        if (commentController.text.isNotEmpty) {
                          var result = await _postComment();
                          if (result) {
                            // ignore: use_build_context_synchronously
                            GetStorage().write(AppConstant.QUESTION_ID,
                                widget.data.questionID);
                            context.go("/question_detail", extra: widget.data);
                          }
                        }
                      }, gradient: AppColors.defaultGradient),
                    ],
                  ),
                ),
              ),
            );
          });
    }

    return InkWell(
      onTap: () => showComment(),
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
                    widget.data.questionContent ?? "",
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
                          Text(widget.data.numberLike?.toString() ?? "")
                        ],
                      ),
                      const SizedBox(width: 30),
                      Row(
                        children: [
                          SvgPicture.asset("assets/comment.svg"),
                          const SizedBox(width: 5),
                          Text(widget.data.numberComment?.toString() ?? "")
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
                    // Text(
                    //   timeago
                    //       .format(data.answer?.dateCreated ?? DateTime.now()),
                    //   style: AppTheme.bodySmall.copyWith(color: Colors.black54),
                    // ),
                  ],
                ),
              ),
              (data.answerContent == null || data.answerContent == '')
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
                              "${data.fullname ?? ''} - ${data.dateSharedName}",
                              style: AppTheme.bodySmall
                                  .copyWith(color: Colors.black54),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              data.answerContent ?? '',
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
