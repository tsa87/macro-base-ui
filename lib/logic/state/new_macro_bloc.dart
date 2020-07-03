import 'dart:convert';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:macrobaseapp/logic/usecases/macro_firestore/firestore_macro_operation.dart';
import 'package:macrobaseapp/model/adapters/action_model.dart';
import 'package:macrobaseapp/model/adapters/macro_model.dart';
import 'package:macrobaseapp/model/adapters/trigger_model.dart';
import 'package:macrobaseapp/model/entities/trigger.dart';
import 'package:macrobaseapp/model/entities/action.dart';

class SerializedFormBloc extends FormBloc<String, String> {
  final macroName = TextFieldBloc(
    name: 'Macro Name',
  );

  final description = TextFieldBloc(
    name: 'Macro Description',
  );

  final triggerType = SelectFieldBloc(
    name: 'Trigger Type',
    items: [Trigger.COMMAND_BASED, Trigger.TIME_BASED],
  );

  final commandBasedFields = TextFieldBloc(
    name: 'Trigger Command',
  );

  final timeBasedFields = InputFieldBloc<DateTime, Object>(
    name: 'Start Time',
    toJson: (value) => value.toUtc().toIso8601String(),
  );

  final actionType = SelectFieldBloc(
    name: 'Action Type',
    items: [Action.POLL_ACTION],
  );

  final pollActionFields = TextFieldBloc(
    name: 'Question',
  );

  SerializedFormBloc() {
    addFieldBlocs(
      fieldBlocs: [
        macroName,
        description,
        triggerType,
        actionType,
      ],
    );
    triggerType.onValueChanges(onData: (previous, current) async* {
      if (current.value == Trigger.COMMAND_BASED) {
        addFieldBlocs(fieldBlocs: [commandBasedFields]);
        removeFieldBlocs(fieldBlocs: [timeBasedFields]);
      } else if (current.value == Trigger.TIME_BASED) {
        addFieldBlocs(fieldBlocs: [timeBasedFields]);
        removeFieldBlocs(fieldBlocs: [commandBasedFields]);
      }
    });

    actionType.onValueChanges(onData: (_, current) async* {
      if (current.value == Action.POLL_ACTION) {
        addFieldBlocs(fieldBlocs: [pollActionFields]);
      }
    });
  }

  @override
  void onSubmitting() async {
    dynamic trigger = null;
    dynamic action = null;

    if (triggerType.value == Trigger.COMMAND_BASED) {
      trigger = new CommandTriggerModel(command: commandBasedFields.value);
    }
    // TODO Time Based

    if (actionType.value == Action.POLL_ACTION) {
      action = new PollActionModel(
        question: pollActionFields.value,
        choices: ["yes", "no"], //TODO Remove hard coded values
        userCanAddOptions: true,
        userCanVoteMultiple: true,
      );
    }

    final macro = MacroModel(
      macroName: macroName.value,
      description: description.value,
      creatorId: "tonyshen@google.com",
      trigger: trigger,
      action: action,
    );

    uploadMacro(macro.toJson());

    emitSuccess(
      canSubmitAgain: true,
      successResponse: JsonEncoder.withIndent('  ').convert(
        macro.toJson(),
      ),
    );
  }
}
