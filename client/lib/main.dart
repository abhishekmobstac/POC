import 'package:client/dashboard_page.dart';
import 'package:client/utils/user_data.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final userValue = await UserSecureStorage.getUserdata() ?? "";
  print(userValue);
  runApp(MyApp(userValue.toString()));
}

class MyApp extends StatelessWidget {
  final String userValue;
  MyApp(this.userValue);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: userValue == "" ? LoginPage() : Dashboard(),
    );
  }
}
