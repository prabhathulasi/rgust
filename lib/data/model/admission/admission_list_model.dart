class AdmissionListModel {
  List<Data>? data;
  String? message;

  AdmissionListModel({this.data, this.message});

  AdmissionListModel.fromJson(Map<String, dynamic> json) {
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
  int? iD;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? title;
  String? photo;
  String? firstName;
  String? lastName;
  String? martialStatus;
  String? emailAddress;
  String? contactNumber;
  String? dob;
  String? gender;
  String? birthCountry;
  String? ethinicity;
  String? citizenship;
  String? passportNumber;
  String? homeAddress;
  String? mailingAddress;
  String? residingCountry;
  bool? studentVisa;
  String? disabilty;
  List<OtherLanguages>? otherLanguages;
  int? applicationStatus;
  String? disablityDetails;

  Data(
      {this.iD,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.title,
      this.photo,
      this.firstName,
      this.lastName,
      this.martialStatus,
      this.emailAddress,
      this.contactNumber,
      this.dob,
      this.gender,
      this.birthCountry,
      this.ethinicity,
      this.citizenship,
      this.passportNumber,
      this.homeAddress,
      this.mailingAddress,
      this.residingCountry,
      this.studentVisa,
      this.disabilty,
      this.otherLanguages,
      this.applicationStatus,
      this.disablityDetails});

  Data.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    deletedAt = json['DeletedAt'].toString();
    title = json['Title'];
    photo = json['Photo'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    martialStatus = json['MartialStatus'];
    emailAddress = json['EmailAddress'];
    contactNumber = json['ContactNumber'];
    dob = json['Dob'];
    gender = json['Gender'];
    birthCountry = json['BirthCountry'];
    ethinicity = json['Ethinicity'];
    citizenship = json['Citizenship'];
    passportNumber = json['PassportNumber'];
    homeAddress = json['HomeAddress'];
    mailingAddress = json['MailingAddress'];
    residingCountry = json['ResidingCountry'];
    studentVisa = json['StudentVisa'];
    disabilty = json['Disabilty'];
    if (json['OtherLanguages'] != null) {
      otherLanguages = <OtherLanguages>[];
      json['OtherLanguages'].forEach((v) {
        otherLanguages!.add(OtherLanguages.fromJson(v));
      });
    }
    applicationStatus = json['ApplicationStatus'];
    disablityDetails = json['DisablityDetails'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['CreatedAt'] = createdAt;
    data['UpdatedAt'] = updatedAt;
    data['DeletedAt'] = deletedAt;
    data['Title'] = title;
    data['Photo'] = photo;
    data['FirstName'] = firstName;
    data['LastName'] = lastName;
    data['MartialStatus'] = martialStatus;
    data['EmailAddress'] = emailAddress;
    data['ContactNumber'] = contactNumber;
    data['Dob'] = dob;
    data['Gender'] = gender;
    data['BirthCountry'] = birthCountry;
    data['Ethinicity'] = ethinicity;
    data['Citizenship'] = citizenship;
    data['PassportNumber'] = passportNumber;
    data['HomeAddress'] = homeAddress;
    data['MailingAddress'] = mailingAddress;
    data['ResidingCountry'] = residingCountry;
    data['StudentVisa'] = studentVisa;
    data['Disabilty'] = disabilty;
    if (otherLanguages != null) {
      data['OtherLanguages'] =
          otherLanguages!.map((v) => v.toJson()).toList();
    }
    data['ApplicationStatus'] = applicationStatus;
    data['DisablityDetails'] = disablityDetails;
    return data;
  }
}

class OtherLanguages {
  int? admissionID;
  String? langName;

  OtherLanguages({this.admissionID, this.langName});

  OtherLanguages.fromJson(Map<String, dynamic> json) {
    admissionID = json['AdmissionID'];
    langName = json['LangName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AdmissionID'] = admissionID;
    data['LangName'] = langName;
    return data;
  }
}
