import 'package:client/utils/user_data.dart';
import 'package:flutter/material.dart';

import './header_page.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future logout() async {
    print("logout");
    await UserSecureStorage.deleteUserdata();
  }

  // final userEmail, userName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [Colors.cyan, Colors.cyan, Colors.cyan]),
        ),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 40,
            ),
            Header("Dashboard"),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )),
              child: Text("Hello"),
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(onPressed: logout, child: Text("Logout"))
          ],
        ),
      ),
    );
  }
}
