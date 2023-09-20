class ProgramClassModel {
  List<ProgramClass>? programClass;

  ProgramClassModel({this.programClass});

  ProgramClassModel.fromJson(Map<String, dynamic> json) {
    if (json['ProgramClass'] != null) {
      programClass = <ProgramClass>[];
      json['ProgramClass'].forEach((v) {
        programClass!.add(ProgramClass.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (programClass != null) {
      data['ProgramClass'] = programClass!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProgramClass {
  int? iD;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? classId;
  String? className;
  int? programId;

  ProgramClass(
      {this.iD,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.classId,
      this.className,
      this.programId});

  ProgramClass.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    deletedAt = json['DeletedAt'].toString();
    classId = json['ClassId'];
    className = json['ClassName'];
    programId = json['ProgramId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['CreatedAt'] = createdAt;
    data['UpdatedAt'] = updatedAt;
    data['DeletedAt'] = deletedAt;
    data['ClassId'] = classId;
    data['ClassName'] = className;
    data['ProgramId'] = programId;
    return data;
  }
}
