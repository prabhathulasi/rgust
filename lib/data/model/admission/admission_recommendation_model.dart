class RecommendationModel {
  String? name;
  String? profession;
  String? position;
  String? collegeName;
  String? address;
  String? phone;
  String? email;

  RecommendationModel({
    this.name,
    this.profession,
    this.position,
    this.collegeName,
    this.address,
    this.phone,
    this.email,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['profession'] = profession;
    data['position'] = position;
    data['collegeName'] = collegeName;
    data['address'] = address;
    data['phone'] = phone;
    data['email'] = email;
    return data;
  }
}
