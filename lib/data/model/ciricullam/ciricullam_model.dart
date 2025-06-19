class CiricullamListModel {
  List<Ciriculum>? ciriculum;
  String? message;

  CiricullamListModel({this.ciriculum, this.message});

  CiricullamListModel.fromJson(Map<String, dynamic> json) {
    if (json['ciriculum'] != null) {
      ciriculum = <Ciriculum>[];
      json['ciriculum'].forEach((v) {
        ciriculum!.add(Ciriculum.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (ciriculum != null) {
      data['ciriculum'] = ciriculum!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class Ciriculum {
  int? id;
  String? ciriculum;
  String? courseName;
  String? startDate;
  String? endDate;
  int? facultyId;

  Ciriculum(
      {this.id,
      this.ciriculum,
      this.courseName,
      this.startDate,
      this.endDate,
      this.facultyId});

  Ciriculum.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ciriculum = json['ciriculum'];
    courseName = json['course_name'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    facultyId = json['faculty_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ciriculum'] = ciriculum;
    data['course_name'] = courseName;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['faculty_id'] = facultyId;
    return data;
  }
}
