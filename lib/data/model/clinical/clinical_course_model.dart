class ClinicalCoursesModel {
  List<Clinicals>? clinicals;
  String? message;

  ClinicalCoursesModel({this.clinicals, this.message});

  ClinicalCoursesModel.fromJson(Map<String, dynamic> json) {
    if (json['Clinicals'] != null) {
      clinicals = <Clinicals>[];
      json['Clinicals'].forEach((v) {
        clinicals!.add(Clinicals.fromJson(v));
      });
    }
    message = json['Message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (clinicals != null) {
      data['Clinicals'] = clinicals!.map((v) => v.toJson()).toList();
    }
    data['Message'] = message;
    return data;
  }
}

class Clinicals {
  int? iD;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? rotationName;
  int? rotationCredits;
  int? rotationDuration;
  String? rotationType;
  int? programId;
  String? createdBy;

  Clinicals(
      {this.iD,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.rotationName,
      this.rotationCredits,
      this.rotationDuration,
      this.rotationType,
      this.programId,
      this.createdBy});

  Clinicals.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    deletedAt = json['DeletedAt'];
    rotationName = json['RotationName'];
    rotationCredits = json['RotationCredits'];
    rotationDuration = json['RotationDuration'];
    rotationType = json['RotationType'];
    programId = json['ProgramId'];
    createdBy = json['CreatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['CreatedAt'] = createdAt;
    data['UpdatedAt'] = updatedAt;
    data['DeletedAt'] = deletedAt;
    data['RotationName'] = rotationName;
    data['RotationCredits'] = rotationCredits;
    data['RotationDuration'] = rotationDuration;
    data['RotationType'] = rotationType;
    data['ProgramId'] = programId;
    data['CreatedBy'] = createdBy;
    return data;
  }
}
