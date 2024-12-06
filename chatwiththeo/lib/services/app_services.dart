import 'dart:convert';

import 'package:chatwiththeo/model/position_model.dart';
import 'package:chatwiththeo/services/http_auth_basic.dart';
import 'package:chatwiththeo/utils/constant.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../model/base_response.dart';
import '../model/categories_model.dart';
import '../model/question_model.dart';
import '../model/schedule_model.dart';
import '../model/user_model.dart';

class AppServices {
  late http.Client _api;
  static const String _baseURL = "http://apichatwiththeo.gvbsoft.vn/";
  AppServices._privateConstructor() {
    _api = BasicAuthClient("username", "password");
  }

  static Map get getAuth => {
        "UserID": GetStorage().read(AppConstant.USER_USER_ID),
        "UUSerID": GetStorage().read(AppConstant.USER_USERNAME)
      };

  static final AppServices _instance = AppServices._privateConstructor();

  static AppServices get instance => _instance;

  Future<ResponseBase<List<CategoryModel>>?> getCategories(int page, int limit,
      {int gameID = 1}) async {
    try {
      var rawResponse = await _api.get(Uri.parse(
          "${_baseURL}api/categorys/getlistbygameid?gameID=$gameID&page=$page&limit=$limit"));
      if (rawResponse.statusCode == 200) {
        return CategoryModel.getFromJson(json.decode(rawResponse.body));
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<ResponseBase<List<QuestionModel>>?> getListQuestion(
      int page, int limit, categoryID) async {
    try {
      var rawResponse = await _api.get(Uri.parse(
          "$_baseURL/api/question/get-question-random-by-cate?page=$page&limit=$limit&userID=${GetStorage().read(AppConstant.USER_USER_ID)}&categoryID=$categoryID"));
      if (rawResponse.statusCode == 200) {
        return QuestionModel.getFromJson(json.decode(rawResponse.body));
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  // Future<ResponseBase<List<AnswerModel>>?> getListAnswerModel(
  //     int page, int limit, int answerModelID) async {
  //   try {
  //     var rawResponse = await _api.get(Uri.parse(
  //         "$_baseURL/api/user-answer-comment/get-list-comment?answerID=$answerModelID&page=$page&limit=$limit"));
  //     if (rawResponse.statusCode == 200) {
  //       return AnswerModel.getFromJson(json.decode(rawResponse.body));
  //     }
  //   } catch (e) {
  //     return null;
  //   }
  //   return null;
  // }

  Future<ResponseBase<List<QuestionModel>>?> getListQuestionAnswer(
      int page, int limit) async {
    try {
      var rawResponse = await _api.get(Uri.parse(
          "${_baseURL}api/answer/get-answer-share?keySearch=&page=$page&limit=$limit"));
      if (rawResponse.statusCode == 200) {
        return QuestionModel.getFromJson(json.decode(rawResponse.body));
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<ResponseBase<List<QuestionModel>>?> getListAnswerByQuestionID(
      int questionID, int page, int limit) async {
    try {
      var userID = await GetStorage().read(AppConstant.USER_USER_ID);
      var rawResponse = await _api.get(Uri.parse(
          "${_baseURL}api/answer/get-answer-by-questionid?userID=$userID&questionID=$questionID&page=$page&limit=$limit"));
      if (rawResponse.statusCode == 200) {
        return QuestionModel.getFromJson(json.decode(rawResponse.body));
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<ResponseBase<UserModel>?> letLogin(
      String userName, String passWord) async {
    try {
      var data = json.encode({"UserName": userName, "PassWord": passWord});
      var rawResponse =
          await _api.post(Uri.parse("${_baseURL}api/user/login"), body: data);
      if (rawResponse.statusCode == 200) {
        return UserModel.getFromJson(json.decode(rawResponse.body));
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<ResponseBase<UserModel>?> getProfile() async {
    try {
      var rawResponse = await _api.get(Uri.parse(
          "${_baseURL}api/user/profile?userID=${GetStorage().read(AppConstant.USER_USER_ID)}"));
      if (rawResponse.statusCode == 200) {
        return UserModel.getFromJson(json.decode(rawResponse.body));
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<ResponseBase<UserModel>?> letRegister(String email, String passWord,
      String phone, String fullName, int positionID) async {
    try {
      var data = json.encode({
        "ImagePath": "",
        "PositionID": positionID,
        "UserName": email,
        "PassWord": passWord,
        "FullName": fullName,
        "Email": email,
        "Address": "",
        "Phone": phone,
        "StatusID": 1,
        "NumberLogin": 0,
        "LastLogin": DateTime.now().toString()
      });
      var rawResponse = await _api
          .post(Uri.parse("${_baseURL}api/user/register"), body: data);
      if (rawResponse.statusCode == 200 &&
          json.decode(rawResponse.body)["message"] == null) {
        return UserModel.getFromJson(json.decode(rawResponse.body));
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<ResponseBase<List<PositionModel>>?> getListPosition() async {
    try {
      var rawResponse = await _api
          .get(Uri.parse("$_baseURL/api/positions/getlistpositionall"));
      if (rawResponse.statusCode == 200) {
        return PositionModel.getFromJson(json.decode(rawResponse.body));
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<ResponseBase<List<ScheduleModel>>?> getListSchedule(
      int page, int limit) async {
    try {
      var rawResponse = await _api.get(Uri.parse(
          "$_baseURL/api/schedule/get-list-paging?userID=${GetStorage().read(AppConstant.USER_USER_ID)}&page=$page&limit=$limit"));
      if (rawResponse.statusCode == 200) {
        return ScheduleModel.getFromJson(json.decode(rawResponse.body));
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<bool> postInsertSchedule(String description, DateTime time) async {
    try {
      var data = json.encode({
        "auth": getAuth,
        "data": {
          "UserID": GetStorage().read(AppConstant.USER_USER_ID),
          "DateSchedule": time.toIso8601String(),
          "Status": 1,
          "Description": description
        }
      });
      var rawResponse = await _api
          .post(Uri.parse("$_baseURL/api/schedule/insert-schdule"), body: data);
      if (rawResponse.statusCode == 200 &&
          json.decode(rawResponse.body)["message"] == null) {
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  Future<bool> postComment(int questionID, String answerContent) async {
    try {
      var data = json.encode({
        "auth": getAuth,
        "data": {"QuestionID": questionID, "AnswerContent": answerContent}
      });
      var rawResponse = await _api
          .post(Uri.parse("$_baseURL/api/answer/insert-answer"), body: data);
      if (rawResponse.statusCode == 200 &&
          json.decode(rawResponse.body)["message"] == null) {
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }
}
