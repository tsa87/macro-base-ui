import 'package:flutter/material.dart';
import 'package:macrobaseapp/logic/state/macro_notifier.dart';
import 'package:macrobaseapp/logic/usecases/macro_firestore/firestore_macro_operation.dart';
import 'package:macrobaseapp/model/entities/user.dart';
import 'package:macrobaseapp/presentation/pages/macro_detail.dart';
import 'package:provider/provider.dart';

class MacroTable extends StatefulWidget {
  final User user;
  MacroTable({this.user});

  @override
  _MacroTableState createState() => _MacroTableState();
}

class _MacroTableState extends State<MacroTable> {
  @override
  void initState() {
    MacroNotifier macroNotifier =
        Provider.of<MacroNotifier>(context, listen: false);
    macroNotifier.userEmail = widget.user.email;
    getMacros(macroNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MacroNotifier macroNotifier = Provider.of<MacroNotifier>(context);

    if (macroNotifier.macroList.length == 0) {
      return Container(
        child: Column(
          children: <Widget>[
            Image(
              image: AssetImage("empty_macro.png"),
              height: 350,
            ),
            Text("It looks empty here... Create your first macro on the left panel!",
              style: TextStyle(
                fontSize: 20,
                color: Colors.green,
              ),
            )
          ],
        ),
      );
    } else {
      return Container(
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                leading: FlutterLogo(size: 72.0),
                title: Text(macroNotifier.macroList[index].macroName),
                subtitle: Text(macroNotifier.macroList[index].description),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    removeMacro(macroNotifier.macroList[index].macroId);
                    macroNotifier.deleteMacro(macroNotifier.macroList[index]);
                  },
                ),
                onTap: () {
                  macroNotifier.currentMacro = macroNotifier.macroList[index];
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return MacroDetail();
                  }));
                },
              ),
            );
          },
          itemCount: macroNotifier.macroList.length,
        ),
      );
    }
  }
}
