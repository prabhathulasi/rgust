class AdmissionDetailModel {
  Data? data;
  String? message;

  AdmissionDetailModel({this.data, this.message});

  AdmissionDetailModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
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
  String? agentName;
  String? agentEmail;
  String? agentContact;
  String? agentAddress;
  String? counselorName;
  String? studentType;
  String? programName;
  String? yearOfAdmission;
  String? semester;
  String? financialType;
  bool? alreadyEnrolled;
  String? universityName;
  String? enrolledProgramName;
  String? transferDocument;
  List<EducationDetails>? educationDetails;
  List<JobDetails>? jobDetails;
  bool? internationalStudent;
  String? engExp;
  String? engLevel;
  bool? examTaken;
  String? document;
  bool? testTaken;
  String? testName;
  String? testLocation;
  String? testDate;
  String? testScore;
  String? testAttempts;
  String? referenceName;
  String? referenceEmail;
  String? referencePhone;
  String? referenceProfession;
  String? referenceAddress;
  String? paymentDate;
  String? paymentName;
  String? signature;
  String? documents;

  Data(
      {this.title,
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
      this.disablityDetails,
      this.agentName,
      this.agentEmail,
      this.agentContact,
      this.agentAddress,
      this.counselorName,
      this.studentType,
      this.programName,
      this.yearOfAdmission,
      this.semester,
      this.financialType,
      this.alreadyEnrolled,
      this.universityName,
      this.enrolledProgramName,
      this.transferDocument,
      this.educationDetails,
      this.jobDetails,
      this.internationalStudent,
      this.engExp,
      this.engLevel,
      this.examTaken,
      this.document,
      this.testTaken,
      this.testName,
      this.testLocation,
      this.testDate,
      this.testScore,
      this.testAttempts,
      this.referenceName,
      this.referenceEmail,
      this.referencePhone,
      this.referenceProfession,
      this.referenceAddress,
      this.paymentDate,
      this.paymentName,
      this.signature,
      this.documents});

  Data.fromJson(Map<String, dynamic> json) {
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
    agentName = json['AgentName'];
    agentEmail = json['AgentEmail'];
    agentContact = json['AgentContact'];
    agentAddress = json['AgentAddress'];
    counselorName = json['CounselorName'];
    studentType = json['StudentType'];
    programName = json['ProgramName'];
    yearOfAdmission = json['YearOfAdmission'];
    semester = json['Semester'];
    financialType = json['FinancialType'];
    alreadyEnrolled = json['AlreadyEnrolled'];
    universityName = json['UniversityName'];
    enrolledProgramName = json['EnrolledProgramName'];
    transferDocument = json['TransferDocument'];
    if (json['EducationDetails'] != null) {
      educationDetails = <EducationDetails>[];
      json['EducationDetails'].forEach((v) {
        educationDetails!.add(EducationDetails.fromJson(v));
      });
    }
    if (json['JobDetails'] != null) {
      jobDetails = <JobDetails>[];
      json['JobDetails'].forEach((v) {
        jobDetails!.add(JobDetails.fromJson(v));
      });
    }
    internationalStudent = json['InternationalStudent'];
    engExp = json['EngExp'];
    engLevel = json['EngLevel'];
    examTaken = json['ExamTaken'];
    document = json['Document'];
    testTaken = json['TestTaken'];
    testName = json['TestName'];
    testLocation = json['TestLocation'];
    testDate = json['TestDate'];
    testScore = json['TestScore'];
    testAttempts = json['TestAttempts'];
    referenceName = json['ReferenceName'];
    referenceEmail = json['ReferenceEmail'];
    referencePhone = json['ReferencePhone'];
    referenceProfession = json['ReferenceProfession'];
    referenceAddress = json['ReferenceAddress'];
    paymentDate = json['PaymentDate'];
    paymentName = json['PaymentName'];
    signature = json['Signature'];
    documents = json['Documents'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    data['AgentName'] = agentName;
    data['AgentEmail'] = agentEmail;
    data['AgentContact'] = agentContact;
    data['AgentAddress'] = agentAddress;
    data['CounselorName'] = counselorName;
    data['StudentType'] = studentType;
    data['ProgramName'] = programName;
    data['YearOfAdmission'] = yearOfAdmission;
    data['Semester'] = semester;
    data['FinancialType'] = financialType;
    data['AlreadyEnrolled'] = alreadyEnrolled;
    data['UniversityName'] = universityName;
    data['EnrolledProgramName'] = enrolledProgramName;
    data['TransferDocument'] = transferDocument;
    if (educationDetails != null) {
      data['EducationDetails'] =
          educationDetails!.map((v) => v.toJson()).toList();
    }
    if (jobDetails != null) {
      data['JobDetails'] = jobDetails!.map((v) => v.toJson()).toList();
    }
    data['InternationalStudent'] = internationalStudent;
    data['EngExp'] = engExp;
    data['EngLevel'] = engLevel;
    data['ExamTaken'] = examTaken;
    data['Document'] = document;
    data['TestTaken'] = testTaken;
    data['TestName'] = testName;
    data['TestLocation'] = testLocation;
    data['TestDate'] = testDate;
    data['TestScore'] = testScore;
    data['TestAttempts'] = testAttempts;
    data['ReferenceName'] = referenceName;
    data['ReferenceEmail'] = referenceEmail;
    data['ReferencePhone'] = referencePhone;
    data['ReferenceProfession'] = referenceProfession;
    data['ReferenceAddress'] = referenceAddress;
    data['PaymentDate'] = paymentDate;
    data['PaymentName'] = paymentName;
    data['Signature'] = signature;
    data['Documents'] = documents;
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

class EducationDetails {
  int? iD;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? admissionID;
  String? highSchoolName;
  String? courseName;
  String? startDate;
  String? endDate;
  String? document;

  EducationDetails(
      {this.iD,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.admissionID,
      this.highSchoolName,
      this.courseName,
      this.startDate,
      this.endDate,
      this.document});

  EducationDetails.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    deletedAt = json['DeletedAt'].toString();
    admissionID = json['AdmissionID'];
    highSchoolName = json['HighSchoolName'];
    courseName = json['CourseName'];
    startDate = json['StartDate'];
    endDate = json['EndDate'];
    document = json['Document'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['CreatedAt'] = createdAt;
    data['UpdatedAt'] = updatedAt;
    data['DeletedAt'] = deletedAt;
    data['AdmissionID'] = admissionID;
    data['HighSchoolName'] = highSchoolName;
    data['CourseName'] = courseName;
    data['StartDate'] = startDate;
    data['EndDate'] = endDate;
    data['Document'] = document;
    return data;
  }
}

class JobDetails {
  int? iD;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  bool? previousExp;
  int? admissionID;
  String? employername;
  String? role;
  String? startDate;
  String? endDate;
  String? document;
  String? jobType;

  JobDetails(
      {this.iD,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.previousExp,
      this.admissionID,
      this.employername,
      this.role,
      this.startDate,
      this.endDate,
      this.document,
      this.jobType});

  JobDetails.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    deletedAt = json['DeletedAt'].toString();
    previousExp = json['PreviousExp'];
    admissionID = json['AdmissionID'];
    employername = json['Employername'];
    role = json['Role'];
    startDate = json['StartDate'];
    endDate = json['EndDate'];
    document = json['Document'];
    jobType = json['JobType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['CreatedAt'] = createdAt;
    data['UpdatedAt'] = updatedAt;
    data['DeletedAt'] = deletedAt;
    data['PreviousExp'] = previousExp;
    data['AdmissionID'] = admissionID;
    data['Employername'] = employername;
    data['Role'] = role;
    data['StartDate'] = startDate;
    data['EndDate'] = endDate;
    data['Document'] = document;
    data['JobType'] = jobType;
    return data;
  }
}
