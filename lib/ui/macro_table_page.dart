import 'package:flutter/material.dart';
import 'package:macrobaseapp/app/services/firestore_service.dart';
import 'package:macrobaseapp/app/services/macro_notifier.dart';
import 'package:macrobaseapp/ui/macro_detail.dart';
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
              subtitle: Text("This is a description of the bot"),
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