class PublishResultModel {
  String? message;
  List<Result>? result;

  PublishResultModel({this.message, this.result});

  PublishResultModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    if (json['Result'] != null) {
      result = <Result>[];
      json['Result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    if (result != null) {
      data['Result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String? programName;
  String? batch;
  String? className;
bool? publish;
  Result({this.programName, this.batch, this.className,this.publish});

  Result.fromJson(Map<String, dynamic> json) {
    programName = json['program_name'];
    batch = json['batch'];
    className = json['class_name'];
    publish = json['publish'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['program_name'] = programName;
    data['batch'] = batch;
    data['class_name'] = className;
     data['publish'] = publish;
    return data;
  }
}
