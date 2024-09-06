class StaffModel {
  String? message;
  List<StaffList>? staffList;

  StaffModel({this.message, this.staffList});

  StaffModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    if (json['StaffList'] != null) {
      staffList = <StaffList>[];
      json['StaffList'].forEach((v) {
        staffList!.add(StaffList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    if (staffList != null) {
      data['StaffList'] = staffList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StaffList {
  int? iD;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? userId;
  String? staffId;
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
  String? designation;
  bool? accountCreated;
  String? empStatus;
  String? lastDate;

  StaffList(
      {this.iD,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.userId,
      this.staffId,
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
      this.designation,
      this.accountCreated,
      this.empStatus,
      this.lastDate});

  StaffList.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    deletedAt = json['DeletedAt'].toString();
    userId = json['UserId'];
    staffId = json['StaffId'];
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
    designation = json['Designation'];
    accountCreated = json['AccountCreated'];
    empStatus = json['EmpStatus'];
    lastDate = json['LastDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['CreatedAt'] = createdAt;
    data['UpdatedAt'] = updatedAt;
    data['DeletedAt'] = deletedAt;
    data['UserId'] = userId;
    data['StaffId'] = staffId;
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
    data['Designation'] = designation;
    data['AccountCreated'] = accountCreated;
    data['EmpStatus'] = empStatus;
    data['LastDate'] = lastDate;
    return data;
  }
}
