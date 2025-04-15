class InvoiceResponseModel {
  List<InvoiceData>? invoiceData;
  String? message;

  InvoiceResponseModel({this.invoiceData, this.message});

  InvoiceResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['invoiceData'] != null) {
      invoiceData = <InvoiceData>[];
      json['invoiceData'].forEach((v) {
        invoiceData!.add(InvoiceData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (invoiceData != null) {
      data['invoiceData'] = invoiceData!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
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
