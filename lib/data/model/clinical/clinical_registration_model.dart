class ClinicalRegistrationModel {
  List<Clinicals>? clinicals;
  String? message;

  ClinicalRegistrationModel({this.clinicals, this.message});

  ClinicalRegistrationModel.fromJson(Map<String, dynamic> json) {
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
  int? clinicalId;
  String? rotationName;
  int? rotationCredits;
  int? rotationDuration;
  String? rotationType;
  int? programId;
  String? createdBy;
  bool? registered;

  Clinicals(
      {this.clinicalId,
      this.rotationName,
      this.rotationCredits,
      this.rotationDuration,
      this.rotationType,
      this.programId,
      this.createdBy,
      this.registered});

  Clinicals.fromJson(Map<String, dynamic> json) {
    clinicalId = json['clinical_id'];
    rotationName = json['rotation_name'];
    rotationCredits = json['rotation_credits'];
    rotationDuration = json['rotation_duration'];
    rotationType = json['rotation_type'];
    programId = json['program_id'];
    createdBy = json['created_by'];
    registered = json['registered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['clinical_id'] = clinicalId;
    data['rotation_name'] = rotationName;
    data['rotation_credits'] = rotationCredits;
    data['rotation_duration'] = rotationDuration;
    data['rotation_type'] = rotationType;
    data['program_id'] = programId;
    data['created_by'] = createdBy;
    data['registered'] = registered;
    return data;
  }
}
