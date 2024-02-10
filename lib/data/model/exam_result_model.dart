class ExamResultModel {
  List<Result>? result;
  String? message;
  String? userType;
  ExamResultModel({this.result});

  ExamResultModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    userType = json["UserType"];
    if (json['Result'] != null) {
      result = <Result>[];
      json['Result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['UserType'] = userType;
    if (result != null) {
      data['Result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  int? iD;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? batch;
  int? programId;
  int? classId;
  int? studentId;
  String? prograName;
  String? className;
  String? courseName;
  String? courseCode;
  int? courseCredits;
  String? cw1;
  String? cw2;
  String? cw3;
  String? cw4;
  String? finalMark;
  bool? ispublish;

  String? grade;
  int? gpa;
  bool? isRepeat;

  Result(
      {this.iD,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.batch,
      this.programId,
      this.classId,
      this.studentId,
      this.courseName,
      this.courseCode,
      this.courseCredits,
      this.cw1,
      this.cw2,
      this.cw3,
      this.cw4,
      this.finalMark,
      this.ispublish,
      this.prograName,
      this.className,
      this.grade,
      this.isRepeat,
      this.gpa});

  Result.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    deletedAt = json['DeletedAt'];
    batch = json['batch'];
    programId = json['ProgramId'];
    classId = json['ClassId'];
    studentId = json['StudentId'];
    courseName = json['course_name'];
    courseCode = json['course_code'];
    courseCredits = json['course_credits'];
    cw1 = json['Cw1'].toString();
    cw2 = json['Cw2'].toString();
    cw3 = json['Cw3'].toString();
    cw4 = json['Cw4'].toString();
    finalMark = json['FinalMark'].toString();

    grade = json['Grade'];
    prograName = json['program_name'];
    className = json['class_name'];
    gpa = json['Gpa'];
    ispublish = json['is_publish'];
    isRepeat = json['is_repeat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['CreatedAt'] = createdAt;
    data['UpdatedAt'] = updatedAt;
    data['DeletedAt'] = deletedAt;
    data['batch'] = batch;
    data['ProgramId'] = programId;
    data['ClassId'] = classId;
    data['StudentId'] = studentId;
    data['course_name'] = courseName;
    data['course_code'] = courseCode;
    data['course_credits'] = courseCredits;
    data['Cw1'] = cw1;
    data['Cw2'] = cw2;
    data['Cw3'] = cw3;
    data['Cw4'] = cw4;
    data['FinalMark'] = finalMark;
    data['is_repeat'] = isRepeat;
    data["is_publish"] = ispublish;

    data['Grade'] = grade;
    data['Gpa'] = gpa;
    data['program_name'] = prograName;
    data['class_name'] = className;
    return data;
  }
}
