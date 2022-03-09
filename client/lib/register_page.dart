import 'package:client/login_page.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:client/user.dart';
import 'package:http/http.dart' as http;

import './header_page.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

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
            // const SizedBox(
            //   height: 80,
            // ),
            Header("Register"),
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
          const SizedBox(
            height: 40,
          ),
          const Text(
            "Forgot Password?",
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(
            height: 40,
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
  UserRegister user = UserRegister('', '', '');

  Future signUp() async {
    var url = Uri.parse('http://localhost:5000/users/register');
    try {
      var response = await http.post(url, body: {
        'name': user.name,
        'email': user.email,
        'password': user.password
      });
      Map<String, dynamic> userData = jsonDecode(response.body);
      print(userData['message']);
      // print(userData['statusCode']);
      // print(response.statusCode);
      if (response.statusCode == 200) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
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
            controller: TextEditingController(text: user.name),
            onChanged: (value) {
              user.name = value;
            },
            decoration: const InputDecoration(
                hintText: "Enter your name",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none),
          ),
        ),
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
          height: 20,
        ),
        ElevatedButton(onPressed: signUp, child: const Text("Register")),
      ],
    );
  }
}
