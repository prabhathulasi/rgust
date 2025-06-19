class FacultyRegisteredCourseModel {
  List<Data>? data;
  String? message;

  FacultyRegisteredCourseModel({this.data, this.message});

  FacultyRegisteredCourseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  int? registrationId;
  int? facultyId;
  int? courseId;
  String? courseName;
  String? courseCode;

  Data(
      {this.registrationId,
      this.facultyId,
      this.courseId,
      this.courseName,
      this.courseCode});

  Data.fromJson(Map<String, dynamic> json) {
    registrationId = json['registration_id'];
    facultyId = json['faculty_id'];
    courseId = json['course_id'];
    courseName = json['course_name'];
    courseCode = json['course_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['registration_id'] = registrationId;
    data['faculty_id'] = facultyId;
    data['course_id'] = courseId;
    data['course_name'] = courseName;
    data['course_code'] = courseCode;
    return data;
  }
}
