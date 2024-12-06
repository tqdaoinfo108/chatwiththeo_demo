import 'base_response.dart';

class ScheduleModel {
    ScheduleModel({
        required this.scheduleId,
        required this.userId,
        required this.dateSchedule,
        required this.status,
        required this.description,
    });

    final int? scheduleId;
    final int? userId;
    final String? dateSchedule;
    final int? status;
    final String? description;

    factory ScheduleModel.fromJson(Map<String, dynamic> json){ 
        return ScheduleModel(
            scheduleId: json["ScheduleID"],
            userId: json["UserID"],
            dateSchedule: json["DateSchedule"],
            status: json["Status"],
            description: json["Description"],
        );
    }
    
  static ResponseBase<List<ScheduleModel>>? getFromJson(
      Map<String, dynamic> json) {
    if (json["message"] == null) {
      var list = <ScheduleModel>[];
      if (json['data'] != null) {
        json['data'].forEach((v) {
          list.add(ScheduleModel.fromJson(v));
        });
      }
      return ResponseBase<List<ScheduleModel>>(
        totals: json['totals'] ?? json['total'],
        data: list,
      );
    } else {
      return ResponseBase();
    }
  }
}
