class InvoiceModel {
  String title;
  String description;
  int usd;
  int gyd;
  int studentId;
  String scholarshipType;
  int scholarshipAmount;

  // Constructor
  InvoiceModel({
    required this.title,
    required this.description,
    required this.usd,
    required this.gyd,
    required this.studentId,
    required this.scholarshipType,
    required this.scholarshipAmount,
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
    };
  }
}
