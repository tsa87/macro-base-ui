import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:macrobaseapp/app/models/macro.dart';

import 'package:macrobaseapp/app/services/macro_notifier.dart';

getMacros(MacroNotifier macroNotifier) async{
  QuerySnapshot snapshot = await Firestore.instance.collection('macros').getDocuments();

  List<Macro> _macroList = [];

  snapshot.documents.forEach((element) {
    Macro macro = Macro.fromJson(element.data);
    _macroList.add(macro);
  });

  macroNotifier.macroList = _macroList;
  print(_macroList);
}