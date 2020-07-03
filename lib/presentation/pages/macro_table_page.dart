import 'package:flutter/material.dart';
import 'package:macrobaseapp/logic/state/macro_notifier.dart';
import 'package:macrobaseapp/logic/usecases/macro_firestore/firestore_macro_operation.dart';
import 'package:macrobaseapp/presentation/pages/macro_detail.dart';
import 'package:provider/provider.dart';

class MacroTable extends StatefulWidget {
  @override
  _MacroTableState createState() => _MacroTableState();
}

class _MacroTableState extends State<MacroTable> {
  @override
  void initState() {
    MacroNotifier macroNotifier =
      Provider.of<MacroNotifier>(context, listen: false);
    getMacros(macroNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MacroNotifier macroNotifier = Provider.of<MacroNotifier>(context);

    return Container(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              leading: FlutterLogo(size: 72.0),
              title: Text(macroNotifier.macroList[index].macroName),
              subtitle: Text(macroNotifier.macroList[index].description),
              trailing: Icon(Icons.delete),
              onTap: () {
                macroNotifier.currentMacro = macroNotifier.macroList[index];
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return MacroDetail();
                  })
                );
              },
            ),
          );
        },
        itemCount: macroNotifier.macroList.length,
      ),
    );
  }
}