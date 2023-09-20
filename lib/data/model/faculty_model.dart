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
  int? programId;
  int? classId;
  String? courseCode;
  String? courseName;
  String? batch;
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

  FacultyList(
      {this.iD,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.programId,
      this.classId,
      this.courseCode,
      this.courseName,
      this.batch,
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
      this.userImage});

  FacultyList.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    deletedAt = json['DeletedAt'].toString();
    programId = json['ProgramId'];
    classId = json['ClassId'];
    courseCode = json['CourseCode'];
    courseName = json['CourseName'];
    batch = json['Batch'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['CreatedAt'] = createdAt;
    data['UpdatedAt'] = updatedAt;
    data['DeletedAt'] = deletedAt;
    data['ProgramId'] = programId;
    data['ClassId'] = classId;
    data['CourseCode'] = courseCode;
    data['CourseName'] = courseName;
    data['Batch'] = batch;
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
    return data;
  }
}
