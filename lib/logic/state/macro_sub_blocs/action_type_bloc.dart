import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:macrobaseapp/model/entities/action.dart';

class ActionTypeBloc {
  final field = SelectFieldBloc(
    name: 'Action Type',
    items: [Action.POLL_ACTION],
    validators: [
      FieldBlocValidators.required,
    ],
  );
}