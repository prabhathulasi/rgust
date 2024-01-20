import 'package:rugst_alliance_academia/data/model/exam_result_model.dart';

class StudentDetailModel {
  String? message;
  StudentDetail? studentDetail;

  StudentDetailModel({this.message, this.studentDetail});

  StudentDetailModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    studentDetail = json['StudentDetail'] != null
        ? StudentDetail.fromJson(json['StudentDetail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    if (studentDetail != null) {
      data['StudentDetail'] = studentDetail!.toJson();
    }
    return data;
  }
}

class StudentDetail {
  int? iD;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? userId;
  String? studentId;
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
  int? feesId;
  String? userImage;
  String? studentType;
  String? mailingAddress;
  String? passportNumber;
  String? qualification;
  String? citizenship;
  bool? accountCreated;
  String? createdBy;

  List<RegisteredCourse>? registeredCourse;
   List<Result>? result;

  StudentDetail(
      {this.iD,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.userId,
      this.studentId,
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
      this.feesId,
      this.userImage,
      this.studentType,
      this.mailingAddress,
      this.passportNumber,
      this.qualification,
      this.citizenship,
      this.accountCreated,
      this.createdBy,
      this.result,
   
      this.registeredCourse});

  StudentDetail.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    deletedAt = json['DeletedAt'];
    userId = json['UserId'];
    studentId = json['StudentId'];
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
    feesId = json['FeesId'];
    userImage = json['UserImage'];
    studentType = json['StudentType'];
    mailingAddress = json['MailingAddress'];
    passportNumber = json['PassportNumber'];
    qualification = json['Qualification'];
    citizenship = json['Citizenship'];
    accountCreated = json['AccountCreated'];
    createdBy = json['CreatedBy'];
   
    if (json['Result'] != null) {
      result = <Result>[];
      json['Result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }
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
    data['UserId'] = userId;
    data['StudentId'] = studentId;
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
    data['FeesId'] = feesId;
    data['UserImage'] = userImage;
    data['StudentType'] = studentType;
    data['MailingAddress'] = mailingAddress;
    data['PassportNumber'] = passportNumber;
    data['Qualification'] = qualification;
    data['Citizenship'] = citizenship;
    data['AccountCreated'] = accountCreated;
    data['CreatedBy'] = createdBy;

    if (result != null) {
      data['Result'] =
          result!.map((v) => v.toJson()).toList();
    }
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
  int? studentId;
  String? batch;
  String? programName;
  String? className;
  String? status;
  String? approvedBy;

  RegisteredCourse(
      {this.iD,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.programId,
      this.classId,
      this.courseName,
      this.courseCode,
      this.studentId,
      this.batch,
      this.programName,
      this.className,
      this.status,
      this.approvedBy});

  RegisteredCourse.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    deletedAt = json['DeletedAt'];
    programId = json['ProgramId'];
    classId = json['ClassId'];
    courseName = json['CourseName'];
    courseCode = json['CourseCode'];
    studentId = json['StudentId'];
    batch = json['Batch'];
    programName = json['ProgramName'];
    className = json['ClassName'];
    status = json['Status'];
    approvedBy = json['ApprovedBy'];
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
    data['StudentId'] = studentId;
    data['Batch'] = batch;
    data['ProgramName'] = programName;
    data['ClassName'] = className;
    data['Status'] = status;
    data['ApprovedBy'] = approvedBy;
    return data;
  }
}


