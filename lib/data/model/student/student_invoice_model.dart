class StudentInvoiceListModel {
  List<InvoiceList>? invoiceList;

  StudentInvoiceListModel({this.invoiceList});

  StudentInvoiceListModel.fromJson(Map<String, dynamic> json) {
    if (json['InvoiceList'] != null) {
      invoiceList = <InvoiceList>[];
      json['InvoiceList'].forEach((v) {
        invoiceList!.add(InvoiceList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (invoiceList != null) {
      data['InvoiceList'] = invoiceList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InvoiceList {
  int? iD;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? studentId;
  String? invoiceName;
  String? invoiceData;
  String? formType;
  int? feesId;
  String? paymentType;
  String? fromAccountNumber;
  String? bankName;
  int? amountInGyd;
  int? amountInUsd;
  String? status;
  String? updatedBy;
  String? dueDate;

  InvoiceList(
      {this.iD,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.studentId,
      this.invoiceName,
      this.invoiceData,
      this.formType,
      this.feesId,
      this.paymentType,
      this.fromAccountNumber,
      this.bankName,
      this.amountInGyd,
      this.amountInUsd,
      this.status,
      this.updatedBy,
      this.dueDate});

  InvoiceList.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    deletedAt = json['DeletedAt'];
    studentId = json['StudentId'];
    invoiceName = json['InvoiceName'];
    invoiceData = json['InvoiceData'];
    formType = json['FormType'];
    feesId = json['FeesId'];
    paymentType = json['PaymentType'];
    fromAccountNumber = json['FromAccountNumber'];
    bankName = json['BankName'];
    amountInGyd = json['AmountInGyd'];
    amountInUsd = json['AmountInUsd'];
    status = json['Status'];
    updatedBy = json['UpdatedBy'];
    dueDate = json['DueDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['CreatedAt'] = createdAt;
    data['UpdatedAt'] = updatedAt;
    data['DeletedAt'] = deletedAt;
    data['StudentId'] = studentId;
    data['InvoiceName'] = invoiceName;
    data['InvoiceData'] = invoiceData;
    data['FormType'] = formType;
    data['FeesId'] = feesId;
    data['PaymentType'] = paymentType;
    data['FromAccountNumber'] = fromAccountNumber;
    data['BankName'] = bankName;
    data['AmountInGyd'] = amountInGyd;
    data['AmountInUsd'] = amountInUsd;
    data['Status'] = status;
    data['UpdatedBy'] = updatedBy;
    data['DueDate'] = dueDate;
    return data;
  }
}
