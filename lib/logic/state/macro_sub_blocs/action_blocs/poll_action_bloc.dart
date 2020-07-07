import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class PollActionBloc {
  final field = TextFieldBloc(
    name: "question",
    validators: [
      FieldBlocValidators.required,
    ],
  );
}
