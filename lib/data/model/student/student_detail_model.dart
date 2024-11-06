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
  List<StudentFees>? studentFees;
  List<Result>? result;
  String ? rotationName;

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
      this.registeredCourse,
      this.rotationName,
      this.studentFees
      });

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
    batch = json['batch'];
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
    rotationName =json["rotation_name"];

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

      if (json['StudentFees'] != null) {
      studentFees = <StudentFees>[];
      json['StudentFees'].forEach((v) {
        studentFees!.add( StudentFees.fromJson(v));
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
    data['batch'] = batch;
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
    data["rotation_name"]= rotationName;

    if (result != null) {
      data['Result'] = result!.map((v) => v.toJson()).toList();
    }
    if (registeredCourse != null) {
      data['RegisteredCourse'] =
          registeredCourse!.map((v) => v.toJson()).toList();
    }
 if (studentFees != null) {
      data['StudentFees'] = studentFees!.map((v) => v.toJson()).toList();
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
  int? courseCredits;

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
      this.courseCredits,
      this.approvedBy});

  RegisteredCourse.fromJson(Map<String, dynamic> json) {
    iD = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    programId = json['program_id'];
    classId = json['class_id'];
    courseName = json['course_name'];
    courseCode = json['course_code'];
    studentId = json['student_id'];
    batch = json['batch'];
    programName = json['program_name'];
    className = json['class_name'];
    status = json['status'];
    approvedBy = json['approved_by'];
    courseCredits = json['course_credits'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = iD;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['program_id'] = programId;
    data['class_id'] = classId;
    data['course_name'] = courseName;
    data['course_code'] = courseCode;
    data['student_id'] = studentId;
    data['batch'] = batch;
    data['program_name'] = programName;
    data['class_name'] = className;
    data['status'] = status;
    data['approved_by'] = approvedBy;
    data["course_credits"] = courseCredits;
    return data;
  }
}
class StudentFees {
  int? iD;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? studentId;
  int? feesId;
  int? classId;
  int? amountInUsd;
  int? amountInGyd;
  String? tutionType;
  String? className;
int ? dueAmount;

  StudentFees(
      {this.iD,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.studentId,
      this.feesId,
      this.classId,
      this.amountInUsd,
      this.amountInGyd,
      this.tutionType,
      this.className,
      this.dueAmount
      });

  StudentFees.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    deletedAt = json['DeletedAt'].toString();
    studentId = json['StudentId'];
    feesId = json['FeesId'];
    classId = json['ClassId'];
    amountInUsd = json['AmountInUsd'];
    amountInGyd = json['AmountInGyd'];
    tutionType = json['TutionType'];
    className =json["ClassName"];
        dueAmount =json["DueAmount"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['CreatedAt'] = createdAt;
    data['UpdatedAt'] = updatedAt;
    data['DeletedAt'] = deletedAt;
    data['StudentId'] = studentId;
    data['FeesId'] = feesId;
    data['ClassId'] = classId;
    data['AmountInUsd'] = amountInUsd;
    data['AmountInGyd'] = amountInGyd;
    data['TutionType'] = tutionType;
    data["ClassName"]= className;
    data["DueAmount"]= dueAmount;
    return data;
  }
}
