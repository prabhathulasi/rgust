class FeesModel{
  List<Feeslist>? feeslist;
  String? message;

  FeesModel({this.feeslist, this.message});

  FeesModel.fromJson(Map<String, dynamic> json) {
    if (json['Feeslist'] != null) {
      feeslist = <Feeslist>[];
      json['Feeslist'].forEach((v) {
        feeslist!.add(Feeslist.fromJson(v));
      });
    }
    message = json['Message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (feeslist != null) {
      data['Feeslist'] = feeslist!.map((v) => v.toJson()).toList();
    }
    data['Message'] = message;
    return data;
  }
}

class Feeslist {
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
  List<MiscellaneousFees>? miscellaneousFees;

  Feeslist(
      {this.iD,
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
      this.miscellaneousFees});

  Feeslist.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    deletedAt = json['DeletedAt'].toString();
    year = json['Year'];
    programId = json['ProgramId'];
    semCount = json['SemCount'];
    programName = json['ProgramName'];
    feesType = json['FeesType'];
    tutionFee = json['TutionFee'];
    createdBy = json['CreatedBy'];
    feesId = json['FeesId'];
    if (json['MiscellaneousFees'] != null) {
      miscellaneousFees = <MiscellaneousFees>[];
      json['MiscellaneousFees'].forEach((v) {
        miscellaneousFees!.add(MiscellaneousFees.fromJson(v));
      });
    }
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
    if (miscellaneousFees != null) {
      data['MiscellaneousFees'] =
          miscellaneousFees!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MiscellaneousFees {
  int? iD;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? feesId;
  bool? isNational;
  String? detail;
  int? miscFee;
  int? programId;

  MiscellaneousFees(
      {this.iD,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.feesId,
      this.isNational,
      this.detail,
      this.miscFee,
      this.programId});

  MiscellaneousFees.fromJson(Map<String, dynamic> json) {
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
