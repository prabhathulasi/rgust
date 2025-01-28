class ExperienceModel {
  String? organization;
  String? employmentType;
  String? role;
  String? from;
  String? till;
  String? document;

  ExperienceModel(
      {this.organization,
      this.employmentType,
      this.role,
      this.from,
      this.till,
      this.document
      });



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Organization'] = organization;
    data['EmploymentType'] = employmentType;
    data['Role'] = role;
    data['From'] = from;
    data['Till'] = till;
    data['Document'] = document;
    return data;
  }
}