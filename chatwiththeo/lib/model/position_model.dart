import 'base_response.dart';

class PositionModel {
  int? positionID;
  String? positionName;
  bool? isActive;

  PositionModel(
      {this.positionID,
      this.positionName,
      this.isActive,
    });

  PositionModel.fromJson(Map<String, dynamic> json) {
    positionID = json['PositionID'];
    positionName = json['PositionName'];
    isActive = json['IsActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PositionID'] = this.positionID;
    data['PositionName'] = this.positionName;
    data['IsActive'] = this.isActive;
    return data;
  }

  
  static ResponseBase<List<PositionModel>>? getFromJson(
      Map<String, dynamic> json) {
    if (json["message"] == null) {
      var list = <PositionModel>[];
      if (json['data'] != null) {
        json['data'].forEach((v) {
          list.add(PositionModel.fromJson(v));
        });
      }
      return ResponseBase<List<PositionModel>>(
        totals: json['totals'] ?? json['total'],
        data: list,
      );
    } else {
      return ResponseBase();
    }
  }
}
