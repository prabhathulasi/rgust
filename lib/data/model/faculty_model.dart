class FacultyModel {
  List<FacultyList>? facultyList;

  FacultyModel({this.facultyList});

  FacultyModel.fromJson(Map<String, dynamic> json) {
    if (json['FacultyList'] != null) {
      facultyList = <FacultyList>[];
      json['FacultyList'].forEach((v) {
        facultyList!.add(FacultyList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (facultyList != null) {
      data['FacultyList'] = facultyList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FacultyList {
  int? iD;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? facultyId;
  String? firstName;
  String? lastName;
  String? email;
  String? gender;
  String? mobile;
  String? dob;
  String? address;
  String? qualifiation;
  int? salary;
  String? joiningDate;
  String? jobType;
  String? passportNumber;
  String? citizenship;
  String? userImage;
  bool? accountCreated;
  List<RegisteredCourse>? registeredCourse;

  FacultyList(
      {this.iD,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.facultyId,
      this.firstName,
      this.lastName,
      this.email,
      this.gender,
      this.mobile,
      this.dob,
      this.address,
      this.qualifiation,
      this.salary,
      this.joiningDate,
      this.jobType,
      this.passportNumber,
      this.citizenship,
      this.userImage,
      this.accountCreated,
      this.registeredCourse});

  FacultyList.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    deletedAt = json['DeletedAt'].toString();
    facultyId = json['FacultyId'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    email = json['Email'];
    gender = json['Gender'];
    mobile = json['Mobile'];
    dob = json['Dob'];
    address = json['Address'];
    qualifiation = json['Qualifiation'];
    salary = json['Salary'];
    joiningDate = json['JoiningDate'];
    jobType = json['JobType'];
    passportNumber = json['PassportNumber'];
    citizenship = json['Citizenship'];
    userImage = json['UserImage'];
    accountCreated = json['AccountCreated'];
    if (json['RegisteredCourse'] != null) {
      registeredCourse = <RegisteredCourse>[];
      json['RegisteredCourse'].forEach((v) {
        registeredCourse!.add(RegisteredCourse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['CreatedAt'] = createdAt;
    data['UpdatedAt'] = updatedAt;
    data['DeletedAt'] = deletedAt;
    data['FacultyId'] = facultyId;
    data['FirstName'] = firstName;
    data['LastName'] = lastName;
    data['Email'] = email;
    data['Gender'] = gender;
    data['Mobile'] = mobile;
    data['Dob'] = dob;
    data['Address'] = address;
    data['Qualifiation'] = qualifiation;
    data['Salary'] = salary;
    data['JoiningDate'] = joiningDate;
    data['JobType'] = jobType;
    data['PassportNumber'] = passportNumber;
    data['Citizenship'] = citizenship;
    data['UserImage'] = userImage;
    data['AccountCreated'] = accountCreated;
    if (registeredCourse != null) {
      data['RegisteredCourse'] =
          registeredCourse!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RegisteredCourse {
  int? iD;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? programId;
  int? classId;
  String? courseName;
  String? courseCode;
  int? facultyId;
  String? batch;
  String? programName;
  String? className;

  RegisteredCourse(
      {this.iD,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.programId,
      this.classId,
      this.courseName,
      this.courseCode,
      this.facultyId,
      this.batch,
      this.programName,
      this.className});

  RegisteredCourse.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    deletedAt = json['DeletedAt'].toString();
    programId = json['ProgramId'];
    classId = json['ClassId'];
    courseName = json['CourseName'];
    courseCode = json['CourseCode'];
    facultyId = json['FacultyId'];
    batch = json['Batch'];
    programName = json['ProgramName'];
    className = json['ClassName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['CreatedAt'] = createdAt;
    data['UpdatedAt'] = updatedAt;
    data['DeletedAt'] = deletedAt;
    data['ProgramId'] = programId;
    data['ClassId'] = classId;
    data['CourseName'] = courseName;
    data['CourseCode'] = courseCode;
    data['FacultyId'] = facultyId;
    data['Batch'] = batch;
    data['ProgramName'] = programName;
    data['ClassName'] = className;
    return data;
  }
}
