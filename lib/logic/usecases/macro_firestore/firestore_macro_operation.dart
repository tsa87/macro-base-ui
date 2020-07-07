import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:macrobaseapp/logic/state/macro_notifier.dart';
import 'package:macrobaseapp/model/adapters/macro_model.dart';
import 'package:macrobaseapp/model/entities/macro.dart';

getMacros(MacroNotifier macroNotifier) async{
  QuerySnapshot snapshot = await Firestore.instance.collection('macros').getDocuments();

  List<Macro> _macroList = [];

  snapshot.documents.forEach((element) {
    Macro macro = MacroModel.fromJson(element.data);
    _macroList.add(macro);
  });

  macroNotifier.macroList = _macroList;
  print(_macroList);
}

uploadMacro(Map<String, dynamic> json) {
  Firestore.instance.collection('macros').document()
      .setData(json);
}

Future<List<Macro>> queryMacro(String macroName) async {
  QuerySnapshot snapshot = await Firestore.instance
    .collection('macros')
    .where("macroName", isEqualTo: macroName)
    .getDocuments();

  List<Macro> _macroList = [];

  snapshot.documents.forEach((element) {
    Macro macro = MacroModel.fromJson(element.data);
    _macroList.add(macro);
    print(macro);
  });

  return _macroList;
}