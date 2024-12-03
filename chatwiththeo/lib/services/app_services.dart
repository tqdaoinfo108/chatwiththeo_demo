import 'dart:convert';

import 'package:chatwiththeo/services/http_auth_basic.dart';
import 'package:chatwiththeo/utils/constant.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../model/answer_model.dart';
import '../model/base_response.dart';
import '../model/categories_model.dart';
import '../model/question_model.dart';
import '../model/user_model.dart';

class AppServices {
  late http.Client _api;
  static String _baseURL = "http://apichatwiththeo.gvbsoft.vn/";
  AppServices._privateConstructor() {
    _api = BasicAuthClient("username", "password");
  }

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
          "${_baseURL}api/question/get-question-random-by-cate?page=$page&limit=$limit&userID=${GetStorage().read(AppConstant.USER_USER_ID)}&categoryID=$categoryID"));
      if (rawResponse.statusCode == 200) {
        return QuestionModel.getFromJson(json.decode(rawResponse.body));
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<ResponseBase<List<AnswerModel>>?> getListAnswerModel(
      int page, int limit, int answerModelID) async {
    try {
      var rawResponse = await _api.get(Uri.parse(
          "${_baseURL}/api/user-answer-comment/get-list-comment?answerID=$answerModelID&page=$page&limit=$limit"));
      if (rawResponse.statusCode == 200) {
        return AnswerModel.getFromJson(json.decode(rawResponse.body));
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<ResponseBase<List<QuestionModel>>?> getListQuestionAnswer(
      int page, int limit) async {
    try {
      var rawResponse = await _api.get(Uri.parse(
          "${_baseURL}api/question/get-question-by-cate?page=$page&limit=$limit"));
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
}
