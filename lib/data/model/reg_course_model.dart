class RegistedCourseModel {
  List<CourseDetails>? courseDetails;
  String? message;

  RegistedCourseModel({this.courseDetails, this.message});

  RegistedCourseModel.fromJson(Map<String, dynamic> json) {
    if (json['CourseDetails'] != null) {
      courseDetails = <CourseDetails>[];
      json['CourseDetails'].forEach((v) {
        courseDetails!.add(CourseDetails.fromJson(v));
      });
    }
    message = json['Message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (courseDetails != null) {
      data['CourseDetails'] =
          courseDetails!.map((v) => v.toJson()).toList();
    }
    data['Message'] = message;
    return data;
  }
}

class CourseDetails {
  int? iD;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? programId;
  String? programName;
  int? classId;
  String? className;
  String? batch;
  String? courseCode;
  String? courseName;
  int? courseCredits;
  int? studentId;
  int? courseId;
  String? status;
  String? approvedBy;

  CourseDetails(
      {this.iD,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.programId,
      this.programName,
      this.classId,
      this.className,
      this.batch,
      this.courseCode,
      this.courseName,
      this.courseCredits,
      this.studentId,
      this.courseId,
      this.status,
      this.approvedBy});

  CourseDetails.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    deletedAt = json['DeletedAt'];
    programId = json['ProgramId'];
    programName = json['ProgramName'];
    classId = json['ClassId'];
    className = json['ClassName'];
    batch = json['Batch'];
    courseCode = json['CourseCode'];
    courseName = json['CourseName'];
    courseCredits = json['CourseCredits'];
    studentId = json['StudentId'];
    courseId = json['CourseId'];
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
    data['ProgramName'] = programName;
    data['ClassId'] = classId;
    data['ClassName'] = className;
    data['Batch'] = batch;
    data['CourseCode'] = courseCode;
    data['CourseName'] = courseName;
    data['CourseCredits'] = courseCredits;
    data['StudentId'] = studentId;
    data['CourseId'] = courseId;
    data['Status'] = status;
    data['ApprovedBy'] = approvedBy;
    return data;
  }
}
