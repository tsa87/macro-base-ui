import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class TimeTriggerFieldBloc {
  final field = SelectFieldBloc(
    items: [
      "day",
      "week",
      "month",
    ],
    validators: [
      FieldBlocValidators.required,
    ],
  );
}
