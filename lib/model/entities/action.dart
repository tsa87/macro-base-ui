import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Action extends Equatable {
  static const String SHEET_ACTION = "Sheet Action";
  static const String POLL_ACTION = "Poll Action";

  final String type;

  Action(@required this.type);

  @override
  List<Object> get props => [type];
}

// TODO: Expand to other operations {Update}
// Defines the operation to append a row to a Google Sheet
class SheetAction extends Action {
  final String sheetUrl;
  final List<String> columns;

  SheetAction({
    @required this.sheetUrl,
    @required this.columns,
  }) : super(Action.SHEET_ACTION);

  @override
  List<Object> get props => super.props..addAll(
    [sheetUrl, columns]);
}

// Defines a Poll action configuration
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
