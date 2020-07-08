import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:macrobaseapp/model/entities/action.dart';

class SheetTypeBloc {
  final field = SelectFieldBloc(
    name: 'Sheet Action',
    validators: [
      FieldBlocValidators.required,
    ],
    items: [SheetAction.APPEND_ACTION],
  );
}
