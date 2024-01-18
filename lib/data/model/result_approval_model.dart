class ApprovalModel {
   String? userType;
  List<ApprovalData>? approvalData;

  ApprovalModel({this.approvalData, this.userType});

  ApprovalModel.fromJson(Map<String, dynamic> json) {
    if (json['ApprovalData'] != null) {
      approvalData = <ApprovalData>[];
      json['ApprovalData'].forEach((v) {
        approvalData!.add(ApprovalData.fromJson(v));
      });
    }
      userType = json['UserType'];
  
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (approvalData != null) {
      data['ApprovalData'] = approvalData!.map((v) => v.toJson()).toList();
    }
     data['userType'] = userType;
    return data;
  }
}

class ApprovalData {
  int? iD;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? status;
  String? resultId;
  int? level;
  String? userType;
  String? approvedBy;
  String? approvedAt;

  ApprovalData(
      {this.iD,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.status,
      this.resultId,
      this.level,
      this.userType,
      this.approvedBy,
      this.approvedAt});

  ApprovalData.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    deletedAt = json['DeletedAt'].toString();
    status = json['Status'];
    resultId = json['ResultId'];
    level = json['Level'];
    userType = json['UserType'];
    approvedBy = json['ApprovedBy'];
    approvedAt = json['ApprovedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['CreatedAt'] = createdAt;
    data['UpdatedAt'] = updatedAt;
    data['DeletedAt'] = deletedAt;
    data['Status'] = status;
    data['ResultId'] = resultId;
    data['Level'] = level;
    data['UserType'] = userType;
    data['ApprovedBy'] = approvedBy;
    data['ApprovedAt'] = approvedAt;
    return data;
  }
}
