import 'base_response.dart';

class UserModel {
  int? userID;
  String? imagesPaths;
  int? typeUserID;
  int? positionID;
  String? userName;
  String? fullName;
  String? email;
  String? address;
  String? phone;
  int? statusID;
  int? numberLogin;
  String? lastLogin;

  UserModel(
      {this.userID,
      this.imagesPaths,
      this.typeUserID,
      this.positionID,
      this.userName,
      this.fullName,
      this.email,
      this.address,
      this.phone,
      this.statusID,
      this.numberLogin,
      this.lastLogin});

  UserModel.fromJson(Map<String, dynamic> json) {
    userID = json['UserID'];
    imagesPaths = json['ImagesPaths'];
    typeUserID = json['TypeUserID'];
    positionID = json['PositionID'];
    userName = json['UserName'];
    fullName = json['FullName'];
    email = json['Email'];
    address = json['Address'];
    phone = json['Phone'];
    statusID = json['StatusID'];
    numberLogin = json['NumberLogin'];
    lastLogin = json['LastLogin'];
  }

  static ResponseBase<UserModel> getFromJson(Map<String, dynamic> json) {
    if (json["message"] == null) {
      return ResponseBase<UserModel>(
        data: UserModel.fromJson(json['data']),
      );
    } else {
      return ResponseBase();
    }
  }
}
