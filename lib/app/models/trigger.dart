import 'dart:convert';

class Trigger {
  Trigger({
    this.type,
    this.time,
    this.stride,
    this.unit,
    this.command,
  });

  String type;
  String time;
  String stride;
  String unit;
  String command;

  factory Trigger.fromRawJson(String str) => Trigger.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Trigger.fromJson(Map<String, dynamic> json) => Trigger(
    type: json["type"],
    time: json["time"] == null ? null : json["time"],
    stride: json["stride"] == null ? null : json["stride"],
    unit: json["unit"] == null ? null : json["unit"],
    command: json["command"] == null ? null : json["command"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "time": time == null ? null : time,
    "stride": stride == null ? null : stride,
    "unit": unit == null ? null : unit,
    "command": command == null ? null : command,
  };
}

