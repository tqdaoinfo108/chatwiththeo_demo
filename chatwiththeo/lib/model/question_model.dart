import 'dart:convert';

import 'package:chatwiththeo/model/base_response.dart';

import 'answer_model.dart';

class QuestionModel {
  int? questionID;
  int? userID;
  String? questionContent;
  String? fullName;
  int? answerID;
  int? numberComment;
  int? numberLike;
  AnswerModel? answer;
  String? userUpdated;
  String? answerContent;
  String? fullname;
  // DateTime? dateShared;
  String? dateAnswerName;
  String? dateSharedName;
  bool? onBackNormal;
  int? questionUserId;

  QuestionModel(
      {this.questionID,
      this.userID,
      this.questionContent,
      this.fullName,
      this.answerID,
      this.numberComment,
      this.numberLike,
      this.onBackNormal});

  QuestionModel.fromJson(Map<String, dynamic> json) {
    // answer =
    //     json['Answer'] != null ? AnswerModel.fromJson(json['Answer']) : null;
    questionID = json['QuestionID'];
    userID = json['UserID'];
    questionContent = json['QuestionContent'];
    fullName = json['FullName'];
    answerID = json['AnswerID'];
    numberComment = json['NumberComment'];
    numberLike = json['NumberLike'];
    answerContent = json["AnswerContent"];
    // dateShared = DateTime.tryParse(json["DateShared"]);
    dateSharedName = json["DateSharedName"];
    dateAnswerName = json["DateAnswerName"];
    fullname = json["FullName"] ?? json["Fullname"];
    userUpdated = json["UserUpdated"];
    onBackNormal = json["onBackNormal"] ?? true;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["QuestionUserID"] = questionUserId;
    _data["QuestionID"] = questionID;
    _data["UserID"] = userID;
    // _data["IsLock"] = isLock;
    _data["AnswerID"] = answerID;
    _data["AnswerContent"] = answerContent;
    // _data["IsShared"] = isShared;
    // _data["DateShared"] = dateShared;
    _data["DateSharedName"] = dateSharedName;
    _data["NumberComment"] = numberComment;
    _data["NumberLike"] = numberLike;
    _data["QuestionContent"] = questionContent;
    _data["Fullname"] = fullname;
    _data["onBackNormal"] = true;
    return _data;
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
