import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class CommandTriggerFieldBloc {
  final field = TextFieldBloc(
    name: 'command',
    validators: [
      FieldBlocValidators.required,
    ],
  );
}
