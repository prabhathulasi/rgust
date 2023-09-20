class CoursesModel {
  List<Courses>? courses;

  CoursesModel({this.courses});

  CoursesModel.fromJson(Map<String, dynamic> json) {
    if (json['Courses'] != null) {
      courses = <Courses>[];
      json['Courses'].forEach((v) {
        courses!.add(Courses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (courses != null) {
      data['Courses'] = courses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Courses {
  int? iD;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? programId;
  int? classId;
  String? courseId;
  String? courseName;
  int? credits;
  String? assignedLec;
  String? batch;

  Courses(
      {this.iD,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.programId,
      this.classId,
      this.courseId,
      this.courseName,
      this.credits,
      this.assignedLec,
      this.batch});

  Courses.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    deletedAt = json['DeletedAt'].toString();
    programId = json['ProgramId'];
    classId = json['ClassId'];
    courseId = json['CourseId'];
    courseName = json['CourseName'];
    credits = json['Credits'];
    assignedLec = json['AssignedLec'];
    batch = json['Batch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['CreatedAt'] = createdAt;
    data['UpdatedAt'] = updatedAt;
    data['DeletedAt'] = deletedAt;
    data['ProgramId'] = programId;
    data['ClassId'] = classId;
    data['CourseId'] = courseId;
    data['CourseName'] = courseName;
    data['Credits'] = credits;
    data['AssignedLec'] = assignedLec;
    data['Batch'] = batch;
    return data;
  }
}
