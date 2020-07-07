import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class MacroDescriptionBloc {
  final field = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
    name: 'Macro Description',
  );
}