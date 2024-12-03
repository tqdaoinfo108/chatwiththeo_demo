import 'base_response.dart';

class AnswerModel {
  int? answerID;
  int? questionUserID;
  String? answerContent;
  DateTime? dateCreated;
  String? dateUpdated;
  String? userCreated;
  bool? isShared;
  String? dateShared;
  String? fullName;

  AnswerModel(
      {this.answerID,
      this.questionUserID,
      this.answerContent,
      this.dateCreated,
      this.dateUpdated,
      this.userCreated,
      this.isShared,
      this.dateShared,
      this.fullName});

  AnswerModel.fromJson(Map<String, dynamic> json) {
    answerID = json['AnswerID'];
    questionUserID = json['QuestionUserID'];
    answerContent = json['AnswerContent'];
    dateCreated = DateTime.tryParse(json['DateCreated']);
    dateUpdated = json['DateUpdated'];
    userCreated = json['UserCreated'];
    isShared = json['IsShared'];
    dateShared = json['DateShared'];
    fullName = json['FullName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AnswerID'] = this.answerID;
    data['QuestionUserID'] = this.questionUserID;
    data['AnswerContent'] = this.answerContent;
    data['DateCreated'] = this.dateCreated;
    data['DateUpdated'] = this.dateUpdated;
    data['UserCreated'] = this.userCreated;
    data['IsShared'] = this.isShared;
    data['DateShared'] = this.dateShared;
    return data;
  }

  
  static ResponseBase<List<AnswerModel>>? getFromJson(
      Map<String, dynamic> json) {
    if (json["message"] == null) {
      var list = <AnswerModel>[];
      if (json['data'] != null) {
        json['data'].forEach((v) {
          list.add(AnswerModel.fromJson(v));
        });
      }
      return ResponseBase<List<AnswerModel>>(
        totals: json['totals'] ?? json['total'],
        data: list,
      );
    } else {
      return ResponseBase();
    }
  }
}