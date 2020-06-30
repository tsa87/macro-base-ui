import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'action/action.dart';
import 'trigger.dart';

class Macro {
  Macro({
    this.macroName,
    this.description,
    this.creator,
    this.creationTime,
    this.triggers,
    this.actions,
  });

  String macroName;
  String description;
  String creator;
  String creationTime;
  List<Trigger> triggers;
  List<Action> actions;

  factory Macro.fromRawJson(String str) => Macro.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Macro.fromJson(Map<String, dynamic> json) => Macro(
    macroName: json["macroName"],
    description: json["description"],
    creator: json["creator"],
    creationTime: json["creationTime"],
    triggers: List<Trigger>.from(json["triggers"].map((x) => Trigger.fromJson(x))),
    actions: List<Action>.from(json["actions"].map((x) => Action.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "macroName": macroName,
    "description": description,
    "creator": creator,
    "creationTime": creationTime,
    "triggers": List<dynamic>.from(triggers.map((x) => x.toJson())),
    "actions": List<dynamic>.from(actions.map((x) => x.toJson())),
  };
}





