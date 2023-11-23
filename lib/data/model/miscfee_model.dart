class MiscFeeModel {
  List<MiscFee>? miscFee;
  int ? semCount;

  MiscFeeModel({this.miscFee, this.semCount});

  MiscFeeModel.fromJson(Map<String, dynamic> json) {
    if (json['MiscFee'] != null) {
      miscFee = <MiscFee>[];
      json['MiscFee'].forEach((v) {
        miscFee!.add(MiscFee.fromJson(v));
      });
    }
    semCount = json['SemCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (miscFee != null) {
      data['MiscFee'] = miscFee!.map((v) => v.toJson()).toList();
    }
      data['SemCount'] = semCount;
    return data;
  }
}

class MiscFee {
  int? iD;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? feesId;
  bool? isNational;
  String? detail;
  int? miscFee;
  int? programId;

  MiscFee(
      {this.iD,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.feesId,
      this.isNational,
      this.detail,
      this.miscFee,
      this.programId});

  MiscFee.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    deletedAt = json['DeletedAt'].toString();
    feesId = json['FeesId'];
    isNational = json['IsNational'];
    detail = json['Detail'];
    miscFee = json['MiscFee'];
    programId = json['ProgramId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['CreatedAt'] = createdAt;
    data['UpdatedAt'] = updatedAt;
    data['DeletedAt'] = deletedAt;
    data['FeesId'] = feesId;
    data['IsNational'] = isNational;
    data['Detail'] = detail;
    data['MiscFee'] = miscFee;
    data['ProgramId'] = programId;
    return data;
  }
}
