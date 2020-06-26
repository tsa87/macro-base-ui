// Adapted from: https://medium.com/flutter-community/flutter-implementing-google-sign-in-71888bca24ed

import 'package:flutter/material.dart';
import '../app/services/firebase_auth_service.dart';
import 'package:provider/provider.dart';

class MainNavigator extends StatelessWidget {
  const MainNavigator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("Macrobase Platform"),
      ),
      body: OutlineButton(
        onPressed: () {
          context.read<FirebaseAuthService>().signOut();
        },
        child: Text("Log out"),
      )
    );
  }
}
