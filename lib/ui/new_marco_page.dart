import 'package:flutter/material.dart';

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}


class MyCustomFormState extends State<MyCustomForm> {

  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Stepper(
        steps: _mySteps(),
        currentStep: this._currentStep,
        onStepTapped: (step){
          setState(() {
            this._currentStep = step;
          });
        },
        onStepContinue: (){
          setState(() {
            if(this._currentStep < this._mySteps().length - 1){
              this._currentStep = this._currentStep + 1;
            }else{
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
      );
  }

  List<Step> _mySteps(){
    List<Step> _steps = [
      Step(
        title: Text('Step 1'),
        content: TextField(),
        isActive: _currentStep >= 0,
      ),
      Step(
        title: Text('Step 2'),
        content: TextField(),
        isActive: _currentStep >= 1,
      ),
      Step(
        title: Text('Step 3'),
        content: TextField(),
        isActive: _currentStep >= 2,
      )
    ];
    return _steps;
  }
}