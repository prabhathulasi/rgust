class PaymentReceiptModel {
  String? message;
  int? totalAmount;
  List<Paymentdata>? paymentdata;

  PaymentReceiptModel({this.message, this.paymentdata, this.totalAmount});

  PaymentReceiptModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    totalAmount = json['totalAmount'];
    if (json['paymentdata'] != null) {
      paymentdata = <Paymentdata>[];
      json['paymentdata'].forEach((v) {
        paymentdata!.add(Paymentdata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['totalAmount'] = totalAmount;
    if (paymentdata != null) {
      data['paymentdata'] = paymentdata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Paymentdata {
  int? iD;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? studentId;
  String? receiptNumber;
  int? invoiceId;
  String? paymentType;
  int? amountInUsd;
  int? amountInGyd;
  String? paymentCopy;

  Paymentdata(
      {this.iD,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.studentId,
      this.receiptNumber,
      this.invoiceId,
      this.paymentType,
      this.amountInUsd,
      this.amountInGyd,
      this.paymentCopy});

  Paymentdata.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    deletedAt = json['DeletedAt'];
    studentId = json['StudentId'];
    receiptNumber = json['ReceiptNumber'];
    invoiceId = json['InvoiceId'];
    paymentType = json['PaymentType'];
    amountInUsd = json['AmountInUsd'];
    amountInGyd = json['AmountInGyd'];
    paymentCopy = json['PaymentCopy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['CreatedAt'] = createdAt;
    data['UpdatedAt'] = updatedAt;
    data['DeletedAt'] = deletedAt;
    data['StudentId'] = studentId;
    data['ReceiptNumber'] = receiptNumber;
    data['InvoiceId'] = invoiceId;
    data['PaymentType'] = paymentType;
    data['AmountInUsd'] = amountInUsd;
    data['AmountInGyd'] = amountInGyd;
    data['PaymentCopy'] = paymentCopy;
    return data;
  }
}
