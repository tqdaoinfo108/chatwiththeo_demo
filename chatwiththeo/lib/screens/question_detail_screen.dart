import 'package:flutter/material.dart';
import '../model/question_model.dart';
import '../services/app_services.dart';
import '../values/app_theme.dart';
import 'components/app_scaffold.dart';

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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AppScaffold(
      hidenSearchButton: true,
      hidenPerson: true,
      hidenBackButton: false,
      hidenNotify: true,
      titlePage: 'Câu hỏi',
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: size.width - 40),
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
                const SizedBox(height: 20),
                Container(
                  constraints: BoxConstraints(minWidth: size.width - 40),
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
                                  constraints:
                                      BoxConstraints(minWidth: size.width - 40),
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
                                          "${item.userUpdated ?? ''} - ${item.answerContent}",
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
