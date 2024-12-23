import 'package:chatwiththeo/values/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';
import '../model/question_model.dart';
import '../services/app_services.dart';
import '../values/app_theme.dart';
import 'components/app_scaffold.dart';

import 'components/app_snackbar.dart';
import 'components/app_textfield.dart';

class QuestionDetailScreen extends StatefulWidget {
  const QuestionDetailScreen({super.key, required this.data});

  final QuestionModel data;
  @override
  State<QuestionDetailScreen> createState() => _QuestionDetailScreenState();
}

class _QuestionDetailScreenState extends State<QuestionDetailScreen> {
  List<QuestionModel> lstData = [];
  @override
  void initState() {
    super.initState();
    initDate();
    if (!context.canPop()) {
      widget.data.onBackNormal = true;
    }
  }

  initDate() async {
    var listCmt = await AppServices.instance
        .getListAnswerByQuestionID(widget.data.questionID!, 1, 50);
    if (listCmt != null) {
      setState(() {
        lstData = listCmt.data ?? [];
      });
    }
  }

  var commentController = TextEditingController();

  Future<bool> _postComment() async {
    var result = await AppServices.instance
        .postComment(widget.data.questionID!, commentController.text);
    if (result) {
      commentController.text = '';
      SnackbarHelper.showSnackBar(
          "Trả lời thành công", ToastificationType.success);
      return true;
    } else {
      SnackbarHelper.showSnackBar("Trả lời thất bại", ToastificationType.error);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AppScaffold(
      contextSecond: context,
      hidenSearchButton: true,
      hidenPerson: true,
      hidenBackButton: false,
      hidenNotify: true,
      titlePage: 'Câu hỏi',
      onBack: () {
        (widget.data.onBackNormal ?? true)
            ? showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Colors.white,
                    title: Text('Thông báo',
                        style:
                            AppTheme.titleLarge.copyWith(color: Colors.black)),
                    content: Text('Bạn có chắc chắn muốn thoát câu hỏi này ?',
                        style:
                            AppTheme.titleMedium.copyWith(color: Colors.black)),
                    actions: <Widget>[
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: Theme.of(context).textTheme.labelLarge,
                        ),
                        child: const Text('Huỷ'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: Theme.of(context).textTheme.labelLarge,
                        ),
                        child: const Text('Đồng ý'),
                        onPressed: () {
                          context.go("/dashboard");
                        },
                      ),
                    ],
                  );
                })
            : context.pop();
      },
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    color: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
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
                  const SizedBox(height: 10),
                  Flexible(
                    child: Card(
                        color: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              for (var item in lstData)
                                QuestionCardDetail(size: size, item: item)
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            ),
            AppTextFormField(
              textInputAction: TextInputAction.none,
              titleText: "",
              labelText: 'Trả lời câu hỏi',
              keyboardType: TextInputType.multiline,
              // controller: commentController,
              enabled: true,
              minLines: 2,
              controller: commentController,
              prefixIcon: IconButton(
                  onPressed: () async {
                    if (commentController.text.isNotEmpty) {
                      var result = await _postComment();
                      if (result) {
                        // ignore: use_build_context_synchronously
                        await initDate();
                      }
                    }
                  },
                  icon: const Icon(
                    Icons.send,
                    color: AppColors.subColor,
                  )),
            ),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}

class QuestionCardDetail extends StatelessWidget {
  const QuestionCardDetail({
    super.key,
    required this.size,
    required this.item,
  });

  final Size size;
  final QuestionModel item;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
            constraints: BoxConstraints(minWidth: size.width - 40),
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: const Color(0xffF4F4F4),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                border: Border.all(
                    color: const Color(0xff000000).withOpacity(.1), width: 1)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "${item.userUpdated ?? ''} - ${item.dateAnswerName}",
                    style: AppTheme.bodySmall.copyWith(color: Colors.black54),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    item.answerContent ?? '',
                    style: AppTheme.bodySmall.copyWith(color: Colors.black54),
                  ),
                )
              ],
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    backgroundColor: Colors.white,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: 200,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () async {
                                  var response = await AppServices.instance
                                      .insertLike(item.answerID!);
                                  if (response != null) {
                                    SnackbarHelper.showSnackBar(
                                        "Thích lời thành công",
                                        ToastificationType.success);
                                  } else {
                                    SnackbarHelper.showSnackBar(
                                        "Thích thất bại",
                                        ToastificationType.error);
                                  }
                                  context.pop();
                                },
                                child: Column(
                                  children: [
                                    SvgPicture.asset("assets/favorite.svg",
                                        height: 60, width: 60),
                                    Text("Thích câu\ntrả lời",
                                        textAlign: TextAlign.center,
                                        style: AppTheme.titleMedium
                                            .copyWith(color: Colors.black))
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  var response = await AppServices.instance
                                      .insertShare(item.answerID!);
                                  if (response != null) {
                                    SnackbarHelper.showSnackBar(
                                        "Chia sẻ thành công",
                                        ToastificationType.success);
                                  } else {
                                    SnackbarHelper.showSnackBar(
                                        "Chia sẻ thất bại",
                                        ToastificationType.error);
                                  }
                                  context.pop();
                                },
                                child: Column(
                                  children: [
                                    SvgPicture.asset("assets/share.svg",
                                        height: 60, width: 60),
                                    Text(
                                      "Chia sẻ\ncộng đồng",
                                      textAlign: TextAlign.center,
                                      style: AppTheme.titleMedium
                                          .copyWith(color: Colors.black),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.more_horiz,
                  color: Colors.grey,
                )),
            const SizedBox(width: 20),
          ],
        ),
      ],
    );
  }
}
