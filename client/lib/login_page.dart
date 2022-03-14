import 'package:client/dashboard_page.dart';
import 'package:client/utils/user_data.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:client/register_page.dart';
import 'package:client/user.dart';

import './header_page.dart';

class LoginPage extends StatelessWidget {
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
            Header("Login"),
            Expanded(
                child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  )),
              child: const InputWrapper(),
            ))
          ],
        ),
      ),
    );
  }
}

class InputWrapper extends StatelessWidget {
  const InputWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 40,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: const InputField(),
          ),

          // Button()
        ],
      ),
    );
  }
}

class InputField extends StatefulWidget {
  const InputField({Key? key}) : super(key: key);

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  UserLogin user = UserLogin('', '');

  Future signIn() async {
    var url = Uri.parse('http://localhost:5000/users/login');
    try {
      var response = await http
          .post(url, body: {'email': user.email, 'password': user.password});
      Map<String, dynamic> userData = jsonDecode(response.body);
      // print(userData['message']);
      // print(userData['statusCode']);
      // print(response.statusCode);
      if (response.statusCode == 200) {
        List<String> userVal = [userData['name'], userData['email']];

        await UserSecureStorage.setUserdata(userVal);
        Fluttertoast.showToast(
            msg: "Login Successfull!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Dashboard()));
      } else if (response.statusCode == 401) {
        Fluttertoast.showToast(
            msg: "Incorrect password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (response.statusCode == 404) {
        Fluttertoast.showToast(
            msg: "User not found",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (response.statusCode == 400) {
        Fluttertoast.showToast(
            msg: "Please enter all the fields",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey))),
          child: TextField(
            controller: TextEditingController(text: user.email),
            onChanged: (value) {
              user.email = value;
            },
            decoration: const InputDecoration(
                hintText: "Enter your email",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey))),
          child: TextField(
            controller: TextEditingController(text: user.password),
            onChanged: (value) {
              user.password = value;
            },
            decoration: const InputDecoration(
                hintText: "Enter your password",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        ElevatedButton(onPressed: signIn, child: const Text("Login")),
        const SizedBox(
          height: 30,
        ),
        InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const RegisterPage()));
          },
          child: const Text(
            "Register",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
