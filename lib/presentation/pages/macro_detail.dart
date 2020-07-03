import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:macrobaseapp/logic/state/macro_notifier.dart';
import 'package:macrobaseapp/model/adapters/macro_model.dart';
import 'package:provider/provider.dart';

class MacroDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MacroNotifier macroNotifier =
        Provider.of<MacroNotifier>(context, listen: false);

    final MacroModel macroModel = macroNotifier.currentMacro;
    final json = JsonEncoder.withIndent('  ').convert(macroModel.toJson());

    return Scaffold(
      appBar: AppBar(
        title: Text(macroModel.macroName),
      ),
      body: Center(
        child: Container(
          child: Text(json),
        ),
      ),
    );
  }
}
