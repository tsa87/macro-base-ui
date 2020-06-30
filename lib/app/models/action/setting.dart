import 'dart:convert';

class Settings {
  Settings({
    this.question,
    this.choices,
    this.userAddOptions,
    this.multipleVotes,
  });

  String question;
  List<String> choices;
  String userAddOptions;
  String multipleVotes;

  factory Settings.fromRawJson(String str) => Settings.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
    question: json["question"],
    choices: List<String>.from(json["choices"].map((x) => x)),
    userAddOptions: json["userAddOptions"],
    multipleVotes: json["multipleVotes"],
  );

  Map<String, dynamic> toJson() => {
    "question": question,
    "choices": List<dynamic>.from(choices.map((x) => x)),
    "userAddOptions": userAddOptions,
    "multipleVotes": multipleVotes,
  };
}
