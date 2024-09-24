class ExperienceModel {
  String? organization;
  String? employmentType;
  String? role;
  String? from;
  String? till;

  ExperienceModel(
      {this.organization,
      this.employmentType,
      this.role,
      this.from,
      this.till});



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['organization'] = organization;
    data['employmentType'] = employmentType;
    data['role'] = role;
    data['from'] = from;
    data['till'] = till;
    return data;
  }
}