class PublishResultModel {
  String? message;
  String? userType;
  List<Results>? results;

  PublishResultModel({this.results});

  PublishResultModel.fromJson(Map<String, dynamic> json) {
     message = json['Message'];
     userType=json["UserType"];
    if (json['Results'] != null) {
      results = <Results>[];
      json['Results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
     data['Message'] = message;
      data['UserType'] = userType;
    if (results != null) {
      data['Results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  int? iD;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? resultId;
  int? programId;
  int? studentId;
  int? courseId;
  int? classId;
  String? cw1;
  String? cw2;
  String? cw3;
  String? cw4;
  String? finalMark;
  String? grade;
  int? gpa;
  String? programName;
  String? className;
  String? batch;
  String? courseName;
  String? courseCode;
  int? courseCredits;
  String? studentName;
  String? studentReg;

  Results(
      {this.iD,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.resultId,
      this.programId,
      this.studentId,
      this.courseId,
      this.classId,
      this.cw1,
      this.cw2,
      this.cw3,
      this.cw4,
      this.finalMark,
      this.grade,
      this.gpa,
      this.programName,
      this.className,
      this.batch,
      this.courseName,
      this.courseCode,
      this.courseCredits,
      this.studentName,
      this.studentReg
      });

  Results.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    deletedAt = json['DeletedAt'].toString();
    resultId = json['ResultId'];
    programId = json['ProgramId'];
    studentId = json['StudentId'];
    courseId = json['CourseId'];
    classId = json['ClassId'];
    cw1 = json['Cw1'];
    cw2 = json['Cw2'];
    cw3 = json['Cw3'];
    cw4 = json['Cw4'];
    finalMark = json['FinalMark'];
    grade = json['Grade'];
    gpa = json['Gpa'];
    programName = json['program_name'];
    className = json['class_name'];
    batch = json['Batch'];
    courseName = json['course_name'];
    courseCode = json['course_code'];
    courseCredits = json['course_credits'];
    studentName = json['student_name'];
    studentReg = json['student_reg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['CreatedAt'] = createdAt;
    data['UpdatedAt'] = updatedAt;
    data['DeletedAt'] = deletedAt;
    data['ResultId'] = resultId;
    data['ProgramId'] = programId;
    data['StudentId'] = studentId;
    data['CourseId'] = courseId;
    data['ClassId'] = classId;
    data['Cw1'] = cw1;
    data['Cw2'] = cw2;
    data['Cw3'] = cw3;
    data['Cw4'] = cw4;
    data['FinalMark'] = finalMark;
    data['Grade'] = grade;
    data['Gpa'] = gpa;
    data['program_name'] = programName;
    data['class_name'] = className;
    data['Batch'] = batch;
    data['course_name'] = courseName;
    data['course_code'] = courseCode;
    data['course_credits'] = courseCredits;
     data['student_name'] = studentName;
      data['student_reg'] = studentReg;
    return data;
  }
}
