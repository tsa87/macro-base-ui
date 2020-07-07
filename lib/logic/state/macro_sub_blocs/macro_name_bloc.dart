import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:macrobaseapp/logic/usecases/macro_firestore/firestore_macro_operation.dart';
import 'package:macrobaseapp/model/entities/macro.dart';

class MacroNameBloc {
  final field = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
    asyncValidators: [asyncValidator],
    name: 'Macro Name',
  );

  static Future<String> asyncValidator(String name) async {
    //Avoid too many Firestore calls
    await Future.delayed(Duration(milliseconds: 200));

    List<Macro> list = await queryMacro(name);

    if (list.length > 0) return "Sorry, this macro name already exist";
    else return null;
  }
}