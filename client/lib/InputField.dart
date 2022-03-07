import 'dart:convert';

import 'package:client/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class InputField extends StatefulWidget {
  const InputField({Key? key}) : super(key: key);

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  User user = User('', '');

  Future signIn() async {
    var url = Uri.parse('http://localhost:5000/users/login');
    try {
      var response = await http
          .post(url, body: {'email': user.email, 'password': user.password});
      Map<String, dynamic> userData = jsonDecode(response.body);
      // print(userData['message']);
      // print(userData['statusCode']);
      // print(response.statusCode);
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
          height: 40,
        ),
        ElevatedButton(onPressed: signIn, child: const Text("Login"))
      ],
    );
  }
}
