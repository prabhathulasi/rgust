class AttendanceModel {
  String? message;
  List<Sessions>? sessions;

  AttendanceModel({this.message, this.sessions});

  AttendanceModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['sessions'] != null) {
      sessions = <Sessions>[];
      json['sessions'].forEach((v) {
        sessions!.add(Sessions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (sessions != null) {
      data['sessions'] = sessions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sessions {
  int? iD;
  String? createdAt;
  String? updatedAt;
  String? startTime;
  String? endTime;

  Sessions(
      {this.iD, this.createdAt, this.updatedAt, this.startTime, this.endTime});

  Sessions.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    startTime = json['start_time'];
    endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['CreatedAt'] = createdAt;
    data['UpdatedAt'] = updatedAt;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    return data;
  }
}
