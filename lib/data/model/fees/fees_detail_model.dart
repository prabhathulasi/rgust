class FeesDetailModel {
  FeesDetails? feesDetails;
  String? message;

  FeesDetailModel({this.feesDetails, this.message});

  FeesDetailModel.fromJson(Map<String, dynamic> json) {
    feesDetails = json['FeesDetails'] != null
        ? FeesDetails.fromJson(json['FeesDetails'])
        : null;
    message = json['Message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (feesDetails != null) {
      data['FeesDetails'] = feesDetails!.toJson();
    }
    data['Message'] = message;
    return data;
  }
}

class FeesDetails {
  int? iD;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? year;
  int? programId;
  int? semCount;
  String? programName;
  String? feesType;
  int? tutionFee;
  String? createdBy;
  int? feesId;
  // List<Null>? miscellaneousFees;

  FeesDetails({
    this.iD,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.year,
    this.programId,
    this.semCount,
    this.programName,
    this.feesType,
    this.tutionFee,
    this.createdBy,
    this.feesId,
    // this.miscellaneousFees
  });

  FeesDetails.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    deletedAt = json['DeletedAt'];
    year = json['Year'];
    programId = json['ProgramId'];
    semCount = json['SemCount'];
    programName = json['ProgramName'];
    feesType = json['FeesType'];
    tutionFee = json['TutionFee'];
    createdBy = json['CreatedBy'];
    feesId = json['FeesId'];
    // if (json['MiscellaneousFees'] != null) {
    //   miscellaneousFees = <Null>[];
    //   json['MiscellaneousFees'].forEach((v) {
    //     miscellaneousFees!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['CreatedAt'] = createdAt;
    data['UpdatedAt'] = updatedAt;
    data['DeletedAt'] = deletedAt;
    data['Year'] = year;
    data['ProgramId'] = programId;
    data['SemCount'] = semCount;
    data['ProgramName'] = programName;
    data['FeesType'] = feesType;
    data['TutionFee'] = tutionFee;
    data['CreatedBy'] = createdBy;
    data['FeesId'] = feesId;
    // if (this.miscellaneousFees != null) {
    //   data['MiscellaneousFees'] =
    //       this.miscellaneousFees!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}
