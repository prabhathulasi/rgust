class EducationModel {
  String? course;
  String? institution;
  String? dateCommenced;
  String? dateCompleted;
  String? selectedFileName;


  EducationModel({
    this.course,
    this.institution,
    this.dateCommenced,
    this.dateCompleted,
    this.selectedFileName, 
   
  });

  Map<String, String?> toJson() {
    return {
      'CourseName': course,
      'InstitutionName': institution,
      'StartDate': dateCommenced,
      'EndDate': dateCompleted,
      "DocumentName": selectedFileName
    };
  }
}
