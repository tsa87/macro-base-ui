import 'package:macrobaseapp/model/entities/action.dart';
import 'package:meta/meta.dart';

class ActionModel extends Action {
  ActionModel({
    @required String type,
  }) : super(type);

  static fromJson(Map<String, dynamic> json) {
    if (json['type'] == Action.POLL_ACTION) {
      return PollActionModel.fromJson(json);
    } else {
      //Error Handling
    }
  }
}

class PollActionModel extends PollAction {
  PollActionModel({
    @required String question,
    @required List<String> choices,
    @required bool userCanAddOptions,
    @required bool userCanVoteMultiple,
  }) : super(
            question: question,
            choices: choices,
            userCanAddOptions: userCanAddOptions,
            userCanVoteMultiple: userCanVoteMultiple);

  factory PollActionModel.fromJson(Map<String, dynamic> json) {
    return PollActionModel(
      question: json['question'],
      choices: json['choices'].cast<String>(),
      userCanAddOptions: json['userCanAddOptions'],
      userCanVoteMultiple: json['userCanVoteMuiltiple'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "question": question,
      "choices": choices,
      "userCanAddOptions": userCanAddOptions,
      "userCanVoteMuiltiple": userCanVoteMultiple
    };
  }
}
