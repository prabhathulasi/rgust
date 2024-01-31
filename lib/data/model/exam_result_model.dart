class ExamResultModel {
  List<Result>? result;

  ExamResultModel({this.result});

  ExamResultModel.fromJson(Map<String, dynamic> json) {
    if (json['Result'] != null) {
      result = <Result>[];
      json['Result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
  String? createdBy;
  String? updatedBy;
  bool? publish;
  String? approvedBy;
  String? grade;
  int? gpa;

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
      this.createdBy,
      this.updatedBy,
      this.publish,
      this.approvedBy,
      this.prograName,
      this.className,
      this.grade,
      this.gpa});

  Result.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    deletedAt = json['DeletedAt'];
    batch = json['Batch'];
    programId = json['ProgramId'];
    classId = json['ClassId'];
    studentId = json['StudentId'];
    courseName = json['CourseName'];
    courseCode = json['CourseCode'];
    courseCredits = json['CourseCredits'];
    cw1 = json['Cw1'].toString();
    cw2 = json['Cw2'].toString();
    cw3 = json['Cw3'].toString();
    cw4 = json['Cw4'].toString();
    finalMark = json['FinalMark'].toString();
    createdBy = json['CreatedBy'];
    updatedBy = json['UpdatedBy'];
    publish = json['Publish'];
    approvedBy = json['ApprovedBy'];
    grade = json['Grade'];
    prograName=json['ProgramName'];
    className = json['ClassName'];
    gpa = json['Gpa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['CreatedAt'] = createdAt;
    data['UpdatedAt'] = updatedAt;
    data['DeletedAt'] = deletedAt;
    data['Batch'] = batch;
    data['ProgramId'] = programId;
    data['ClassId'] = classId;
    data['StudentId'] = studentId;
    data['CourseName'] = courseName;
    data['CourseCode'] = courseCode;
    data['CourseCredits'] = courseCredits;
    data['Cw1'] = cw1;
    data['Cw2'] = cw2;
    data['Cw3'] = cw3;
    data['Cw4'] = cw4;
    data['FinalMark'] = finalMark;
    data['CreatedBy'] = createdBy;
    data['UpdatedBy'] = updatedBy;
    data['Publish'] = publish;
    data['ApprovedBy'] = approvedBy;
    data['Grade'] = grade;
    data['Gpa'] = gpa;
   data['ProgramName']=  prograName;
    data['ClassName']=className;
    return data;
  }
}
