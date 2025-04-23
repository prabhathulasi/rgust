class InvoiceResponseModel {
  List<InvoiceData>? invoiceData;
  String? message;
  List<MiscData>? miscData;

  InvoiceResponseModel({this.invoiceData, this.message, this.miscData});

  InvoiceResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['invoiceData'] != null) {
      invoiceData = <InvoiceData>[];
      json['invoiceData'].forEach((v) {
        invoiceData!.add(InvoiceData.fromJson(v));
      });
    }
    message = json['message'];
    if (json['miscData'] != null) {
      miscData = <MiscData>[];
      json['miscData'].forEach((v) {
        miscData!.add(MiscData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (invoiceData != null) {
      data['invoiceData'] = invoiceData!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    if (miscData != null) {
      data['miscData'] = miscData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InvoiceData {
  int? iD;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? studentId;
  String? invoiceNumber;
  String? invoiceType;
  String? scholorshipType;
  int? year;
  int? regularTutionFee;
  int? scholarhipAmount;
  String? invoiceDescription;
  int? amountInUsd;
  int? currentConversionRate;
  String? customMessage;

  InvoiceData(
      {this.iD,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.studentId,
      this.invoiceNumber,
      this.invoiceType,
      this.scholorshipType,
      this.year,
      this.regularTutionFee,
      this.scholarhipAmount,
      this.invoiceDescription,
      this.amountInUsd,
      this.currentConversionRate,
      this.customMessage});

  InvoiceData.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    deletedAt = json['DeletedAt'].toString();
    studentId = json['StudentId'];
    invoiceNumber = json['InvoiceNumber'];
    invoiceType = json['InvoiceType'];
    scholorshipType = json['ScholorshipType'];
    year = json['Year'];
    regularTutionFee = json['RegularTutionFee'];
    scholarhipAmount = json['ScholarhipAmount'];
    invoiceDescription = json['InvoiceDescription'];
    amountInUsd = json['AmountInUsd'];
    currentConversionRate = json['CurrentConversionRate'];
    customMessage = json['CustomMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['CreatedAt'] = createdAt;
    data['UpdatedAt'] = updatedAt;
    data['DeletedAt'] = deletedAt;
    data['StudentId'] = studentId;
    data['InvoiceNumber'] = invoiceNumber;
    data['InvoiceType'] = invoiceType;
    data['ScholorshipType'] = scholorshipType;
    data['Year'] = year;
    data['RegularTutionFee'] = regularTutionFee;
    data['ScholarhipAmount'] = scholarhipAmount;
    data['InvoiceDescription'] = invoiceDescription;
    data['AmountInUsd'] = amountInUsd;
    data['CurrentConversionRate'] = currentConversionRate;
    data['CustomMessage'] = customMessage;
    return data;
  }
}

class MiscData {
  int? iD;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? studentId;
  String? invoiceNumber;
  int? year;
  String? miscInvoiceDescription;
  int? amountInUsd;
  int? currentConversionRate;
  String? customMessage;
  String? approvalStatus;

  MiscData(
      {this.iD,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.studentId,
      this.invoiceNumber,
      this.year,
      this.miscInvoiceDescription,
      this.amountInUsd,
      this.currentConversionRate,
      this.customMessage,
      this.approvalStatus});

  MiscData.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    deletedAt = json['DeletedAt'].toString();
    studentId = json['StudentId'];
    invoiceNumber = json['InvoiceNumber'];
    year = json['Year'];
    miscInvoiceDescription = json['MiscInvoiceDescription'];
    amountInUsd = json['AmountInUsd'];
    currentConversionRate = json['CurrentConversionRate'];
    customMessage = json['CustomMessage'];
    approvalStatus = json['ApprovalStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['CreatedAt'] = createdAt;
    data['UpdatedAt'] = updatedAt;
    data['DeletedAt'] = deletedAt;
    data['StudentId'] = studentId;
    data['InvoiceNumber'] = invoiceNumber;
    data['Year'] = year;
    data['MiscInvoiceDescription'] = miscInvoiceDescription;
    data['AmountInUsd'] = amountInUsd;
    data['CurrentConversionRate'] = currentConversionRate;
    data['CustomMessage'] = customMessage;
    data['ApprovalStatus'] = approvalStatus;
    return data;
  }
}
