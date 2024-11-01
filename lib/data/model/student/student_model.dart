class StudentModel {
  String? message;
  List<StudentList>? studentList;

  StudentModel({this.message, this.studentList});

  StudentModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    if (json['StudentList'] != null) {
      studentList = <StudentList>[];
      json['StudentList'].forEach((v) {
        studentList!.add(StudentList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    if (studentList != null) {
      data['StudentList'] = studentList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StudentList {
  int? iD;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? studentRegiterNumber;
  int? currentProgramId;
  String? currentProgramName;
  int? currentClassId;
  String? currentClassName;
  String? batch;
  String? admissionDate;
  int? emergencyContact;
  String? firstName;
  String? lastName;
  String? email;
  int? mobileNumber;
  String? dOB;
  String? gender;
  String? address;
  int? tutionFee;
  String? userImage;
  String? studentType;
  String? mailingAddress;
  String? passportNumber;
  String? citizenship;
  bool? accountCreated;
  String? qualifiation;
   String? createdBy;
   int ?fullTutionFee;
   String ? rotationName;
  

  StudentList(
      {this.iD,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.studentRegiterNumber,
      this.currentProgramId,
      this.currentProgramName,
      this.currentClassId,
      this.currentClassName,
      this.batch,
      this.admissionDate,
      this.emergencyContact,
      this.firstName,
      this.lastName,
      this.email,
      this.mobileNumber,
      this.dOB,
      this.gender,
      this.address,
      this.tutionFee,
      this.userImage,
      this.studentType,
      this.mailingAddress,
      this.passportNumber,
      this.citizenship,
      this.accountCreated,
      this.qualifiation,
      this.fullTutionFee,
   this.rotationName,
      this.createdBy
      });

  StudentList.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    deletedAt = json['DeletedAt'];
    studentRegiterNumber = json['StudentId'];
    currentProgramId = json['CurrentProgramId'];
    currentProgramName = json['program_name'];
    currentClassId = json['CurrentClassId'];
    currentClassName = json['class_name'];
    batch = json['Batch'];
    admissionDate = json['AdmissionDate'];
    emergencyContact = json['EmergencyContact'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    email = json['Email'];
    mobileNumber = json['MobileNumber'];
    dOB = json['DOB'];
    gender = json['Gender'];
    address = json['Address'];
    tutionFee = json['TutionFee'];
    userImage = json['UserImage'];
    studentType = json['StudentType'];
    mailingAddress = json['MailingAddress'];
    passportNumber = json['PassportNumber'];
    citizenship = json['Citizenship'];
    accountCreated = json['AccountCreated'];
    createdBy =json["CreatedBy"];
        qualifiation = json['Qualification'];
        fullTutionFee = json["FullTutionFee"];
        rotationName = json["rotation_name"];
 
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['CreatedAt'] = createdAt;
    data['UpdatedAt'] = updatedAt;
    data['DeletedAt'] = deletedAt;
    data['StudentId'] = studentRegiterNumber;
    data['CurrentProgramId'] = currentProgramId;
    data['program_name'] = currentProgramName;
    data['CurrentClassId'] = currentClassId;
    data['class_name'] = currentClassName;
    data['Batch'] = batch;
    data['AdmissionDate'] = admissionDate;
    data['EmergencyContact'] = emergencyContact;
    data['FirstName'] = firstName;
    data['LastName'] = lastName;
    data['Email'] = email;
    data['MobileNumber'] = mobileNumber;
    data['DOB'] = dOB;
    data['Gender'] = gender;
    data['Address'] = address;
    data['TutionFee'] = tutionFee;
    data['UserImage'] = userImage;
    data['StudentType'] = studentType;
    data['MailingAddress'] = mailingAddress;
    data['PassportNumber'] = passportNumber;
    data['Citizenship'] = citizenship;
    data['AccountCreated'] = accountCreated;
    data["Qualification"] = qualifiation;
    data["CreatedBy"]=createdBy;
    data["FullTutionFee"]= fullTutionFee;
    data["rotation_name"]= rotationName;
 
    return data;
  }
}
