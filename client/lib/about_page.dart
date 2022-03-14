import 'package:client/header_page.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  var userName, userEmail;
  AboutPage({this.userName, this.userEmail});

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
            Header("About Page"),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )),
              child: const Text(
                  "MobStac started with a simple mission: to connect the digital and physical worlds through the use of innovative technology. With worldwide smartphone usage skyrocketing, our co-founders Sharat Potharaju and Ravi Pratap realized that they would first need to address the world of mobile in pursuit of this goal. In June 2009, they founded MobStac in order to improve the accessibility and quality of mobile experiences offered by businesses and brands around the world. In these early years, we focused on helping publishers build adaptive mobile sites that would work seamlessly across multiple devices."),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              width: double.infinity,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            height: 100,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "Beacons",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Icon(
                                  Icons.all_out,
                                )
                              ],
                            )),
                      ),
                      Expanded(
                        child: Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            height: 100,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "NFC",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Icon(
                                  Icons.all_out,
                                )
                              ],
                            )),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            height: 100,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "WIFI",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Icon(
                                  Icons.all_out,
                                )
                              ],
                            )),
                      ),
                      Expanded(
                        child: Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            height: 100,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "Bluetooth",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Icon(
                                  Icons.all_out,
                                )
                              ],
                            )),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            height: 100,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "Geofencing",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Icon(
                                  Icons.all_out,
                                )
                              ],
                            )),
                      ),
                      Expanded(
                        child: Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            height: 100,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "QR Codes",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Icon(
                                  Icons.all_out,
                                )
                              ],
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
