import 'package:chatwiththeo/model/base_response.dart';

import 'answer_model.dart';

class QuestionModel {
  int? questionID;
  int? userID;
  String? questionContent;
  String? fullName;
  int? answerID;
  DateTime? dateCreated;
  int? numberComment;
  int? numberLike;
  AnswerModel? answer;

  QuestionModel(
      {this.questionID,
      this.userID,
      this.questionContent,
      this.fullName,
      this.answerID,
      this.dateCreated,
      this.numberComment,
      this.numberLike});

  QuestionModel.fromJson(Map<String, dynamic> json) {
    answer =
        json['Answer'] != null ?  AnswerModel.fromJson(json['Answer']) : null;
    questionID = json['QuestionID'];
    userID = json['UserID'];
    questionContent = json['QuestionContent'];
    fullName = json['FullName'];
    answerID = json['AnswerID'];
    dateCreated = DateTime.tryParse(json['DateCreated']);
    numberComment = json['NumberComment'];
    numberLike = json['NumberLike'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['QuestionID'] = this.questionID;
    data['UserID'] = this.userID;
    data['QuestionContent'] = this.questionContent;
    data['FullName'] = this.fullName;
    data['AnswerID'] = this.answerID;
    data['DateCreated'] = this.dateCreated;
    data['NumberComment'] = this.numberComment;
    data['NumberLike'] = this.numberLike;
    return data;
  }

  static ResponseBase<List<QuestionModel>>? getFromJson(
      Map<String, dynamic> json) {
    if (json["message"] == null) {
      var list = <QuestionModel>[];
      if (json['data'] != null) {
        json['data'].forEach((v) {
          list.add(QuestionModel.fromJson(v));
        });
      }
      return ResponseBase<List<QuestionModel>>(
        totals: json['totals'] ?? json['total'],
        data: list,
      );
    } else {
      return ResponseBase();
    }
  }
}
