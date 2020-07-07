import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:macrobaseapp/model/entities/trigger.dart';

class TriggerTypeBloc {
  final field = SelectFieldBloc(
    name: 'Trigger Type',
    validators: [
      FieldBlocValidators.required,
    ],
    items: [Trigger.COMMAND_BASED, Trigger.TIME_BASED],
  );
}
