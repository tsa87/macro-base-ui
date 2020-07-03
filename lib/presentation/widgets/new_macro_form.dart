import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:macrobaseapp/logic/state/new_macro_bloc.dart';


class SerializedForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      child: BlocProvider(
        create: (context) => SerializedFormBloc(),
        child: Builder(
          builder: (context) {
            final formBloc = context.bloc<SerializedFormBloc>();

            return FormBlocListener<SerializedFormBloc, String, String>(
              onSuccess: (context, state) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(state.successResponse),
                  duration: Duration(seconds: 2),
                ));
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      TextFieldBlocBuilder(
                        textFieldBloc: formBloc.macroName,
                        decoration: InputDecoration(
                          labelText: 'Macro Name',
                          prefixIcon: Icon(Icons.android),
                        ),
                      ),
                      TextFieldBlocBuilder(
                        textFieldBloc: formBloc.description,
                        decoration: InputDecoration(
                          labelText: 'One line description of the macro',
                          prefixIcon: Icon(Icons.book),
                        ),
                      ),
                      RadioButtonGroupFieldBlocBuilder<String>(
                        selectFieldBloc: formBloc.triggerType,
                        itemBuilder: (context, value) => value,
                        decoration: InputDecoration(
                          labelText: 'Trigger Type',
                          prefixIcon: SizedBox(),
                        ),
                      ),
                      TextFieldBlocBuilder(
                        textFieldBloc: formBloc.commandBasedFields,
                        decoration: InputDecoration(
                          labelText: 'Command to trigger the macro',
                        ),
                      ),
                      DateTimeFieldBlocBuilder(
                        dateTimeFieldBloc: formBloc.timeBasedFields,
                        format: DateFormat('dd-mm-yyyy'),
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                        decoration: InputDecoration(
                          labelText: 'Start time',
                          prefixIcon: Icon(Icons.calendar_today),
                        ),
                      ),
                      RadioButtonGroupFieldBlocBuilder<String>(
                        selectFieldBloc: formBloc.actionType,
                        itemBuilder: (context, value) => value,
                        decoration: InputDecoration(
                          labelText: 'Action Type',
                          prefixIcon: SizedBox(),
                        ),
                      ),
                      TextFieldBlocBuilder(
                        textFieldBloc: formBloc.pollActionFields,
                        decoration: InputDecoration(
                          labelText: 'Poll Question',
                        ),
                      ),
                      FloatingActionButton(
                        onPressed: formBloc.submit,
                        child: Icon(Icons.send),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
