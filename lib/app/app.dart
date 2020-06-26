import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';
import '../ui/login_page.dart';
import '../ui/main_navigator.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Macrobase Platform',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: Consumer<User> (
          builder: (_, user, __) {
            if (user == null) {
              return const LoginPage();
            } else {
              return const MainNavigator();
            }
          },
      ),
    );
  }
}