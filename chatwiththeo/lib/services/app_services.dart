import 'package:chatwiththeo/services/http_auth_basic.dart';
import 'package:http/http.dart' as http;

class AppServices {
  late http.Client _api;

  AppServices._privateConstructor() {
    _api = BasicAuthClient("username", "password");
  }

  static final AppServices _instance = AppServices._privateConstructor();

  static AppServices get instance => _instance;

  getCategories(int page, int limit, {int gameID = 1}) async {
    return await _api.get(Uri.parse(
        "http://apichatwiththeo.gvbsoft.vn/api/categorys/getlistbygameid?gameID=$gameID&page=$page&limit=$limit"));
  }
}
