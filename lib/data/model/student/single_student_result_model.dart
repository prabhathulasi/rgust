class SingleStudentResultModel {
  List<Results>? results;

  SingleStudentResultModel({this.results});

  SingleStudentResultModel.fromJson(Map<String, dynamic> json) {
    if (json['Results'] != null) {
      results = <Results>[];
      json['Results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (results != null) {
      data['Results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String? className;
  String? courseName;
  String? courseWork;
  String? finalMarks;
  String? courseCode;

  int? credits;
  String? grade;

  Results(
      {this.className,
      this.finalMarks,
      this.courseWork,
      this.courseCode,
      this.courseName,
      this.credits,
      this.grade});

  Results.fromJson(Map<String, dynamic> json) {
    className = json['class_name'];
    courseCode = json['course_code'];
    courseName = json["course_name"];
    credits = json["credits"];
    grade = json['grade'];
    courseWork = json['course_work'].toString();
    finalMarks = json["final_mark"].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['class_name'] = className;
    data['course_name'] = courseName;
    data['course_code'] = courseCode;
    data['credits'] = credits;
    data['course_work'] = courseWork;
    data['final_mark'] = finalMarks;
    data['grade'] = grade;
    return data;
  }
}