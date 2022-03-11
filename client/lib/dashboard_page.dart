import 'package:client/about_page.dart';
import 'package:client/login_page.dart';
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
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  String userName = "No user", userEmail = "No email";
  getUserData() async {
    var userData = await UserSecureStorage.getUserdata();
    setState(() {
      userName = userData![0];
      userEmail = userData[1];
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

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
              child: Text(
                "Hello " + userName + " and your user email is " + userEmail,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(onPressed: logout, child: Text("Logout")),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AboutPage()));
                },
                child: Text("About"))
          ],
        ),
      ),
    );
  }
}
