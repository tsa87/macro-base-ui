import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Action extends Equatable {
  static final String POLL_ACTION = "Poll Action";
  final String type;

  Action(@required this.type);

  @override
  List<Object> get props => [type];
}

class PollAction extends Action {
  final String question;
  final List<String> choices;
  final bool userCanAddOptions;
  final bool userCanVoteMultiple;

  PollAction({
    @required this.question,
    @required this.choices,
    @required this.userCanAddOptions,
    @required this.userCanVoteMultiple,
  }) : super(Action.POLL_ACTION);

  @override
  List<Object> get props => super.props..addAll(
      [question, choices, userCanAddOptions, userCanVoteMultiple]);
}
