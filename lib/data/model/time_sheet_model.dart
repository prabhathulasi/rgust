class FacultyTimeSheetModel {
  String? message;
  List<Attendance>? attendance;

  FacultyTimeSheetModel({this.message, this.attendance});

  FacultyTimeSheetModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    if (json['attendance'] != null) {
      attendance = <Attendance>[];
      json['attendance'].forEach((v) {
        attendance!.add(Attendance.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    if (attendance != null) {
      data['attendance'] = attendance!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attendance {
  int? iD;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? facultyId;
  int? classId;
  String? courseId;
  String? activity;
  String? startTime;
  String? endTime;
  String? comments;
  List<StudentList>? studentList;
  String? signature;

  Attendance(
      {this.iD,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.facultyId,
      this.classId,
      this.courseId,
      this.activity,
      this.startTime,
      this.endTime,
      this.comments,
      this.studentList,
      this.signature});

  Attendance.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    deletedAt = json['DeletedAt'];
    facultyId = json['FacultyId'];
    classId = json['ClassId'];
    courseId = json['CourseId'];
    activity = json['Activity'];
    startTime = json['StartTime'];
    endTime = json['EndTime'];
    comments = json['Comments'];
    if (json['StudentList'] != null) {
      studentList = <StudentList>[];
      json['StudentList'].forEach((v) {
        studentList!.add(StudentList.fromJson(v));
      });
    }
    signature = json['Signature'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['CreatedAt'] = createdAt;
    data['UpdatedAt'] = updatedAt;
    data['DeletedAt'] = deletedAt;
    data['FacultyId'] = facultyId;
    data['ClassId'] = classId;
    data['CourseId'] = courseId;
    data['Activity'] = activity;
    data['StartTime'] = startTime;
    data['EndTime'] = endTime;
    data['Comments'] = comments;
    if (studentList != null) {
      data['StudentList'] = studentList!.map((v) => v.toJson()).toList();
    }
    data['Signature'] = signature;
    return data;
  }
}

class StudentList {
  int? iD;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? studentId;
  String? name;
  bool? studentAttended;
  String? classDate;
  int? attendanceId;

  StudentList(
      {this.iD,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.studentId,
      this.name,
      this.studentAttended,
      this.classDate,
      this.attendanceId});

  StudentList.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    deletedAt = json['DeletedAt'];
    studentId = json['StudentId'];
    name = json['Name'];
    studentAttended = json['StudentAttended'];
    classDate = json['ClassDate'];
    attendanceId = json['AttendanceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['CreatedAt'] = createdAt;
    data['UpdatedAt'] = updatedAt;
    data['DeletedAt'] = deletedAt;
    data['StudentId'] = studentId;
    data['Name'] = name;
    data['StudentAttended'] = studentAttended;
    data['ClassDate'] = classDate;
    data['AttendanceId'] = attendanceId;
    return data;
  }
}
