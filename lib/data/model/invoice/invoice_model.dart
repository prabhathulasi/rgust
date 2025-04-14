class InvoiceModel {
  String title;
  String description;
  int usd;
  int gyd;
  int studentId;
  String scholarshipType;
  int scholarshipAmount;
  int regularTuitionFee ;

  // Constructor
  InvoiceModel({
    required this.title,
    required this.description,
    required this.usd,
    required this.gyd,
    required this.studentId,
    required this.scholarshipType,
    required this.scholarshipAmount,
    required this.regularTuitionFee,
  });

  // You can create a factory constructor to create an Item from a Map
  factory InvoiceModel.fromMap(Map<String, dynamic> map) {
    return InvoiceModel(
      title: map['title'],
      description: map['description'],
      usd: map['usd'],
      gyd: map['gyd'],
      studentId: map['studentId'],
      scholarshipType: map['scholarshipType'],
      scholarshipAmount: map['scholarshipAmount'],
      regularTuitionFee: map['regularTuitionFee'],
    );
  }

  // Method to convert the Item to a Map (useful for saving data or APIs)
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'usd': usd,
      'gyd': gyd,
      'studentId': studentId,
      'scholarshipType': scholarshipType,
      'scholarshipAmount': scholarshipAmount,
      'regularTuitionFee': regularTuitionFee,
    };
  }
}


class MiscInvoiceModel {
  String? year;
  String? description;
  int? usd;
  int? conversionrate;
  int? studentId;

  MiscInvoiceModel(
      {this.year, this.description, this.usd, this.conversionrate, this.studentId});

  MiscInvoiceModel.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    description = json['description'];
    
    usd = json['usd'];
    conversionrate = json['conversionrate'];
    studentId = json['studentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['year'] = year;
    data['description'] = description;
    data['usd'] = usd;
    data['conversionrate'] = conversionrate;
    data['studentId'] = studentId;
    return data;
  }
}
