import 'dart:convert';

class Procedure {
  Procedure({
    this.operation,
    this.fileType,
    this.templateUrl,
  });

  String operation;
  String fileType;
  String templateUrl;

  factory Procedure.fromRawJson(String str) => Procedure.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Procedure.fromJson(Map<String, dynamic> json) => Procedure(
    operation: json["operation"],
    fileType: json["fileType"],
    templateUrl: json["templateUrl"],
  );

  Map<String, dynamic> toJson() => {
    "operation": operation,
    "fileType": fileType,
    "templateUrl": templateUrl,
  };
}