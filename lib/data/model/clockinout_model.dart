class ClockInandOutModel {
  List<Data>? data;

  ClockInandOutModel({this.data});

  ClockInandOutModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? iD;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? userId;
  String? status;
  String? checkInTime;
  String? checkOutTime;
  String? username;
  String? usertype;
  String? userImage;

  Data(
      {this.iD,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.userId,
      this.status,
      this.checkInTime,
      this.checkOutTime,
      this.username,
      this.userImage,
      this.usertype});

  Data.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    deletedAt = json['DeletedAt'].toString();
    userId = json['UserId'];
    status = json['Status'];
    checkInTime = json['CheckInTime'];
    checkOutTime = json['CheckOutTime'];
    username = json['username'];
    usertype = json['usertype'];
    userImage=json["userimage"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['CreatedAt'] = createdAt;
    data['UpdatedAt'] = updatedAt;
    data['DeletedAt'] = deletedAt;
    data['UserId'] = userId;
    data['Status'] = status;
    data['CheckInTime'] = checkInTime;
    data['CheckOutTime'] = checkOutTime;
    data['username'] = username;
    data['usertype'] = usertype;
    data["userimage"]= userImage;
    return data;
  }
}
