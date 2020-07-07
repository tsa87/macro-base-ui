import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:macrobaseapp/logic/state/macro_bloc.dart';

class SerializedForm extends StatefulWidget {
  SerializedForm({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SerializedFormState createState() => _SerializedFormState();
}

class _SerializedFormState extends State<SerializedForm> {
  int _currentStep = 0;

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
        child: Builder(builder: (context) {
          final formBloc = context.bloc<SerializedFormBloc>();

          return FormBlocListener<SerializedFormBloc, String, String>(
            onSubmitting: (contex, state) {
              LoadingDialog.show(context);
            },
            onSuccess: (context, state) {
              LoadingDialog.hide(context);
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(state.successResponse),
                duration: Duration(seconds: 2),
              ));
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stepper(
                  steps: _mySteps(formBloc),
                  currentStep: this._currentStep,
                  onStepTapped: (step) {
                    setState(() {
                      this._currentStep = step;
                    });
                  },
                  onStepContinue: () {
                    setState(() {
                      if (this._currentStep <
                          this._mySteps(formBloc).length - 1) {
                        this._currentStep = this._currentStep + 1;
                      } else {
                        //Logic to check if everything is completed
                        print('Completed, check fields.');
                      }
                    });
                  },
                  onStepCancel: () {
                    setState(() {
                      if (this._currentStep > 0) {
                        this._currentStep = this._currentStep - 1;
                      } else {
                        this._currentStep = 0;
                      }
                    });
                  },
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  List<Step> _mySteps(formBloc) {
    List<Step> _steps = [
      Step(
        title: Text('Basic Info'),
        content: Column(children: <Widget>[
          TextFieldBlocBuilder(
            textFieldBloc: formBloc.macroNameBloc.field,
            suffixButton: SuffixButton.asyncValidating,
            decoration: InputDecoration(
              labelText: 'Macro Name',
              prefixIcon: Icon(Icons.android),
            ),
          ),
          TextFieldBlocBuilder(
            textFieldBloc: formBloc.macroDescriptionBloc.field,
            decoration: InputDecoration(
              labelText: 'One line description of the macro',
              prefixIcon: Icon(Icons.book),
            ),
          ),
        ]),
        isActive: _currentStep >= 0,
      ),
      Step(
        title: Text("Trigger Condition"),
        content: Column(
          children: <Widget>[
            RadioButtonGroupFieldBlocBuilder<String>(
              selectFieldBloc: formBloc.triggerTypeBloc.field,
              itemBuilder: (context, value) => value,
              decoration: InputDecoration(
                labelText: 'Trigger Type',
                prefixIcon: SizedBox(),
              ),
            ),
            TextFieldBlocBuilder(
              textFieldBloc: formBloc.commandTriggerFieldBloc.field,
              decoration: InputDecoration(
                labelText: 'Command to trigger the macro',
              ),
            ),
            DropdownFieldBlocBuilder<String>(
              selectFieldBloc: formBloc.timeTriggerFieldBloc.field,
              decoration: InputDecoration(
                labelText: "Interval Type for Time Trigger",
              ),
              itemBuilder: (context, value) => value,
            ),
          ],
        ),
        isActive: _currentStep >= 1,
      ),
      Step(
        title: Text("Action"),
        content: Column(
          children: <Widget>[
            RadioButtonGroupFieldBlocBuilder<String>(
              selectFieldBloc: formBloc.actionTypeBloc.field,
              itemBuilder: (context, value) => value,
              decoration: InputDecoration(
                labelText: 'Action Type',
                prefixIcon: SizedBox(),
              ),
            ),
            TextFieldBlocBuilder(
              textFieldBloc: formBloc.pollActionFieldBloc.field,
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
        isActive: _currentStep >= 2,
      )
    ];
    return _steps;
  }
}

class LoadingDialog extends StatelessWidget {
  static void show(BuildContext context, {Key key}) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => LoadingDialog(key: key),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  LoadingDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Card(
          child: Container(
            width: 80,
            height: 80,
            padding: EdgeInsets.all(12.0),
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
