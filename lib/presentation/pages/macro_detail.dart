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
          padding: const EdgeInsets.all(32),
          child: Row(
            children: [
              Expanded(
                /*1*/
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /*2*/
                    Container(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        macroModel.macroName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      macroModel.description,
                      style: TextStyle(
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
              /*3*/
              Icon(
                Icons.star,
                color: Colors.red[500],
              ),
              Text(macroModel.action.type),
            ],
          ),
        )
      ),
    );
  }
}
