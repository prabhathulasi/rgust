class StudentRegisterCourseModel {
  List<StudentCourses>? studentCourses;

  StudentRegisterCourseModel({this.studentCourses});

  StudentRegisterCourseModel.fromJson(Map<String, dynamic> json) {
    if (json['StudentCourses'] != null) {
      studentCourses = <StudentCourses>[];
      json['StudentCourses'].forEach((v) {
        studentCourses!.add(StudentCourses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (studentCourses != null) {
      data['StudentCourses'] =
          studentCourses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StudentCourses {
  int? iD;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? programId;
  int? classId;
  String? courseName;
  String? courseCode;
  int? studentId;
  String? batch;
  String? programName;
  String? className;
  String? status;
  String? approvedBy;

  StudentCourses(
      {this.iD,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.programId,
      this.classId,
      this.courseName,
      this.courseCode,
      this.studentId,
      this.batch,
      this.programName,
      this.className,
      this.status,
      this.approvedBy});

  StudentCourses.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    deletedAt = json['DeletedAt'].toString();
    programId = json['ProgramId'];
    classId = json['ClassId'];
    courseName = json['CourseName'];
    courseCode = json['CourseCode'];
    studentId = json['StudentId'];
    batch = json['Batch'];
    programName = json['ProgramName'];
    className = json['ClassName'];
    status = json['Status'];
    approvedBy = json['ApprovedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['CreatedAt'] = createdAt;
    data['UpdatedAt'] = updatedAt;
    data['DeletedAt'] = deletedAt;
    data['ProgramId'] = programId;
    data['ClassId'] = classId;
    data['CourseName'] = courseName;
    data['CourseCode'] = courseCode;
    data['StudentId'] = studentId;
    data['Batch'] = batch;
    data['ProgramName'] = programName;
    data['ClassName'] = className;
    data['Status'] = status;
    data['ApprovedBy'] = approvedBy;
    return data;
  }
}
