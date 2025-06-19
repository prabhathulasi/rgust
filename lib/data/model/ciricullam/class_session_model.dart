class ClassSessionModel {
  List<Curriculums>? curriculums;
  String? message;
  Session? session;
  List<Students>? students;

  ClassSessionModel(
      {this.curriculums, this.message, this.session, this.students});

  ClassSessionModel.fromJson(Map<String, dynamic> json) {
    if (json['curriculums'] != null) {
      curriculums = <Curriculums>[];
      json['curriculums'].forEach((v) {
        curriculums!.add(Curriculums.fromJson(v));
      });
    }
    message = json['message'];
    session =
        json['session'] != null ? Session.fromJson(json['session']) : null;
    if (json['students'] != null) {
      students = <Students>[];
      json['students'].forEach((v) {
        students!.add(Students.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (curriculums != null) {
      data['curriculums'] = curriculums!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    if (session != null) {
      data['session'] = session!.toJson();
    }
    if (students != null) {
      data['students'] = students!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Curriculums {
  int? id;
  String? name;

  Curriculums({this.id, this.name});

  Curriculums.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Session {
  int? iD;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? courseId;
  int? facultyId;
  String? startTime;
  String? endTime;
  String? signature;
  String? comments;

  Session(
      {this.iD,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.courseId,
      this.facultyId,
      this.startTime,
      this.endTime,
      this.signature,
      this.comments});

  Session.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    deletedAt = json['DeletedAt'].toString();
    courseId = json['course_id'];
    facultyId = json['faculty_id'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    signature = json['signature'];
    comments = json['comments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['CreatedAt'] = createdAt;
    data['UpdatedAt'] = updatedAt;
    data['DeletedAt'] = deletedAt;
    data['course_id'] = courseId;
    data['faculty_id'] = facultyId;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['signature'] = signature;
    data['comments'] = comments;
    return data;
  }
}

class Students {
  int? id;
  String? firstName;
  String? lastName;

  Students({this.id, this.firstName, this.lastName});

  Students.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    return data;
  }
}
