class MediaFileModel {
  List<Files>? files;

  MediaFileModel({this.files});

  MediaFileModel.fromJson(Map<String, dynamic> json) {
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(Files.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (files != null) {
      data['files'] = files!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Files {
  int? iD;
  String? name;
  String? data;
  String? formType;
  int? userID;

  Files({this.iD, this.name, this.data, this.userID});

  Files.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    name = json['Name'];
    data = json['Data'];
    userID = json['UserID'];
    formType= json["FormType"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['Name'] = name;
    data['Data'] = this.data;
    data['UserID'] = userID;
    data["FormType"]= formType;
    return data;
  }
}
