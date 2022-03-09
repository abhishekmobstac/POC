import 'package:flutter/material.dart';

import './header_page.dart';

class Dashboard extends StatelessWidget {
  var userEmail, userName;
  Dashboard(this.userName, this.userEmail);

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
            Expanded(
                child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )),
              child: Expanded(
                  child: Text("Hello welcome ${userName} with ${userEmail}")),
            ))
          ],
        ),
      ),
    );
  }
}
