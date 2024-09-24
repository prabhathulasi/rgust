class EducationModel {
  String? course;
  String? institution;
  String? dateCommenced;
  String? dateCompleted;

  EducationModel({
    this.course,
    this.institution,
    this.dateCommenced,
    this.dateCompleted,
  });

  Map<String, String?> toJson() {
    return {
      'course': course,
      'institution': institution,
      'dateCommenced': dateCommenced,
      'dateCompleted': dateCompleted,
    };
  }
}
