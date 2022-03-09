import 'dart:convert';

import 'package:client/dashboard_page.dart';
import 'package:client/utils/user_data.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';

Future main() async {
  // dynamic token = FlutterSession().get('token');

  WidgetsFlutterBinding.ensureInitialized();
  // final userValue = await UserSecureStorage.getUserdata() ?? "";
  // var value = json.decode(userValue.toString());
  // print(userValue.toString());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
