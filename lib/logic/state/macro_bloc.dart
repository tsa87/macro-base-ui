import 'dart:convert';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:macrobaseapp/logic/state/macro_sub_blocs/action_blocs/poll_action_bloc.dart';
import 'package:macrobaseapp/logic/state/macro_sub_blocs/action_type_bloc.dart';
import 'package:macrobaseapp/logic/state/macro_sub_blocs/trigger_blocs/command_trigger_bloc.dart';
import 'package:macrobaseapp/logic/state/macro_sub_blocs/macro_description_bloc.dart';
import 'package:macrobaseapp/logic/state/macro_sub_blocs/macro_name_bloc.dart';
import 'package:macrobaseapp/logic/state/macro_sub_blocs/trigger_blocs/time_trigger_field_bloc.dart';
import 'package:macrobaseapp/logic/state/macro_sub_blocs/trigger_type_bloc.dart';
import 'package:macrobaseapp/logic/usecases/macro_firestore/firestore_macro_operation.dart';
import 'package:macrobaseapp/model/adapters/action_model.dart';
import 'package:macrobaseapp/model/adapters/macro_model.dart';
import 'package:macrobaseapp/model/adapters/trigger_model.dart';
import 'package:macrobaseapp/model/entities/trigger.dart';
import 'package:macrobaseapp/model/entities/action.dart';
import 'package:macrobaseapp/model/entities/user.dart';

class SerializedFormBloc extends FormBloc<String, String> {
  final macroNameBloc = MacroNameBloc();
  final macroDescriptionBloc = MacroDescriptionBloc();

  final triggerTypeBloc = TriggerTypeBloc();
  final commandTriggerFieldBloc = CommandTriggerFieldBloc();
  final timeTriggerFieldBloc = TimeTriggerFieldBloc();

  final actionTypeBloc = ActionTypeBloc();
  final pollActionFieldBloc = PollActionBloc();

  final User user;

  SerializedFormBloc({this.user}) {
    addFieldBlocs(
      fieldBlocs: [
        macroNameBloc.field,
        macroDescriptionBloc.field,
        triggerTypeBloc.field,
        actionTypeBloc.field,
      ],
    );

    //Expand hidden fields of trigger
    triggerTypeBloc.field.onValueChanges(onData: (_, current) async* {
      removeFieldBlocs(
        fieldBlocs: [commandTriggerFieldBloc.field, timeTriggerFieldBloc.field],
      );
      if (current.value == Trigger.COMMAND_BASED) {
        addFieldBlocs(fieldBlocs: [commandTriggerFieldBloc.field]);
      } else if (current.value == Trigger.TIME_BASED) {
        addFieldBlocs(fieldBlocs: [timeTriggerFieldBloc.field]);
      }
    });

    actionTypeBloc.field.onValueChanges(onData: (_, current) async* {
      removeFieldBlocs(
        fieldBlocs: [pollActionFieldBloc.field],
      );
      if (current.value == Action.POLL_ACTION) {
        addFieldBlocs(fieldBlocs: [pollActionFieldBloc.field]);
      }
    });
  }

  @override
  void onSubmitting() async {
    dynamic trigger = null;
    dynamic action = null;

    switch (triggerTypeBloc.field.value) {
      case (Trigger.COMMAND_BASED):
        {
          trigger = new CommandTriggerModel(
              command: commandTriggerFieldBloc.field.value);
        }
        break;
      case (Trigger.TIME_BASED):
        {
          // TODO
        }
        break;
      default:
        {
          // TODO
        }
        break;
    }

    switch (actionTypeBloc.field.value) {

      case (Action.POLL_ACTION):
        {
          final pollActionBloc = PollActionBloc();
          action = new PollActionModel(
            question: pollActionBloc.field.value,
            choices: ["yes", "no"], //TODO Remove hard coded values
            userCanAddOptions: true,
            userCanVoteMultiple: true,
          );
        }
        break;

      default:
        {
          // TODO
        }
        break;
    }

    final macro = MacroModel(
      macroName: macroNameBloc.field.value.trim(),
      description: macroDescriptionBloc.field.value.trim(),
      creatorId: this.user.email,
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
