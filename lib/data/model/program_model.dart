class ProgramModel {
  List<Program>? program;

  ProgramModel({this.program});

  ProgramModel.fromJson(Map<String, dynamic> json) {
    if (json['Program'] != null) {
      program = <Program>[];
      json['Program'].forEach((v) {
        program!.add(Program.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (program != null) {
      data['Program'] = program!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Program {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? programId;
  String? programname;

  Program(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.programId,
      this.programname});

  Program.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    deletedAt = json['DeletedAt'];
    programId = json['ProgramId'];
    programname = json['Programname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = id;
    data['CreatedAt'] = createdAt;
    data['DeletedAt'] = updatedAt;
   
    data['deleted_at'] = deletedAt;
    data['ProgramId'] = programId;
    data['Programname'] = programname;
    return data;
  }
}
