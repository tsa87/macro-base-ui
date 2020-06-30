import 'package:flutter/material.dart';
import 'package:macrobaseapp/app/services/macro_notifier.dart';
import 'package:provider/provider.dart';

class MacroDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MacroNotifier macroNotifier =
        Provider.of<MacroNotifier>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(macroNotifier.currentMacro.macroName),
      ),
      body: Center(
        child: Container(
          child: Text("DETAILS"),
        ),
      ),
    );
  }
}
