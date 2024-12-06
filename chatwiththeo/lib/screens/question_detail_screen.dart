import 'package:chatwiththeo/values/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';
import '../model/question_model.dart';
import '../services/app_services.dart';
import '../values/app_theme.dart';
import 'components/app_scaffold.dart';

import 'components/app_snackbar.dart';
import 'components/app_textfield.dart';

class QuestionDetailScreen extends StatefulWidget {
  const QuestionDetailScreen({
    super.key,
    required this.data,
  });

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
        showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title:  Text('Thông báo', style: AppTheme.titleLarge.copyWith(color: Colors.black)),
                content: const Text(
                  'Bạn có chắc chắn muốn thoát câu hỏi này ?',
                ),
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
            });
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
                                Container(
                                    constraints: BoxConstraints(
                                        minWidth: size.width - 40),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text(
                                            "${item.userUpdated ?? ''} - ${item.dateAnswerName}",
                                            style: AppTheme.bodySmall
                                                .copyWith(
                                                    color: Colors.black54),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Text(
                                            item.answerContent ?? '',
                                            style: AppTheme.bodySmall
                                                .copyWith(
                                                    color: Colors.black54),
                                          ),
                                        )
                                      ],
                                    ))
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
