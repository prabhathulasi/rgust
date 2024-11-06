class SemFeesDetailsModel {
  List<SemFeeDetails>? semFeeDetails;

  SemFeesDetailsModel({this.semFeeDetails});

  SemFeesDetailsModel.fromJson(Map<String, dynamic> json) {
    if (json['SemFeeDetails'] != null) {
      semFeeDetails = <SemFeeDetails>[];
      json['SemFeeDetails'].forEach((v) {
        semFeeDetails!.add(SemFeeDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (semFeeDetails != null) {
      data['SemFeeDetails'] =
          semFeeDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SemFeeDetails {
  int? iD;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? studentId;
  int? feesId;
  int? classId;
  int? amountInUsd;
  int? amountInGyd;
  String? tutionType;
  String? className;
  String? dueAmount;

  SemFeeDetails(
      {this.iD,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.studentId,
      this.feesId,
      this.classId,
      this.amountInUsd,
      this.amountInGyd,
      this.tutionType,
      this.className,
      this.dueAmount});

  SemFeeDetails.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    deletedAt = json['DeletedAt'];
    studentId = json['StudentId'];
    feesId = json['FeesId'];
    classId = json['ClassId'];
    amountInUsd = json['AmountInUsd'];
    amountInGyd = json['AmountInGyd'];
    tutionType = json['TutionType'];
    className = json['ClassName'];
    dueAmount = json['DueAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['CreatedAt'] = createdAt;
    data['UpdatedAt'] = updatedAt;
    data['DeletedAt'] = deletedAt;
    data['StudentId'] = studentId;
    data['FeesId'] = feesId;
    data['ClassId'] = classId;
    data['AmountInUsd'] = amountInUsd;
    data['AmountInGyd'] = amountInGyd;
    data['TutionType'] = tutionType;
    data['ClassName'] = className;
    data['DueAmount'] = dueAmount;
    return data;
  }
}
