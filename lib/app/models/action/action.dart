import 'dart:convert';
import 'setting.dart';
import 'procedure.dart';

class Action {
  Action({
    this.type,
    this.notes,
    this.settings,
    this.procedure,
  });

  String type;
  String notes;
  Settings settings;
  Procedure procedure;

  factory Action.fromRawJson(String str) => Action.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Action.fromJson(Map<String, dynamic> json) => Action(
    type: json["type"],
    notes: json["notes"] == null ? null : json["notes"],
    settings: json["settings"] == null ? null : Settings.fromJson(json["settings"]),
    procedure: json["procedure"] == null ? null : Procedure.fromJson(json["procedure"]),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "notes": notes == null ? null : notes,
    "settings": settings == null ? null : settings.toJson(),
    "procedure": procedure == null ? null : procedure.toJson(),
  };
}