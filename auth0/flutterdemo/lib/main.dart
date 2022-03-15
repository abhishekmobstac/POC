/// -----------------------------------
///          External Packages
/// -----------------------------------

import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final FlutterAppAuth appAuth = FlutterAppAuth();
final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

/// -----------------------------------
///           Auth0 Variables
/// -----------------------------------
const AUTH0_DOMAIN = 'dev-w-p1bzc1.us.auth0.com';
const AUTH0_CLIENT_ID = 'OzyVhAIAObDdlygXCzaENFAimCKZFbo4';

const AUTH0_REDIRECT_URI = 'com.auth0.flutterdemo://login-callback';
const AUTH0_ISSUER = 'https://$AUTH0_DOMAIN';

/// -----------------------------------
///           Profile Widget
/// -----------------------------------
class Profile extends StatelessWidget {
  final logoutAction;
  final String name;
  final String email;
  final String picture;

  Profile(this.logoutAction, this.name, this.picture, this.email);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 4.0),
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(picture),
            ),
          ),
        ),
        SizedBox(height: 24.0),
        Text('Name: $name'),
        Text("Email: $email"),
        SizedBox(height: 48.0),
        ElevatedButton(
          onPressed: () {
            logoutAction();
          },
          child: Text('Logout'),
        ),
      ],
    );
  }
}

/// -----------------------------------
///            Login Widget
/// -----------------------------------
class Login extends StatelessWidget {
  final loginAction;
  final String loginError;

  const Login(this.loginAction, this.loginError);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
          onPressed: () {
            loginAction();
          },
          child: Text('Login'),
        ),
        Text(loginError),
      ],
    );
  }
}

/// -----------------------------------
///                 App
/// -----------------------------------

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

/// -----------------------------------
///              App State
/// -----------------------------------

class _MyAppState extends State<MyApp> {
  bool isBusy = false;
  bool isLoggedIn = false;
  String? errorMessage;
  String? name;
  String? email;
  String? picture;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth0 Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Auth0 Demo'),
        ),
        body: Center(
          child: isBusy
              ? CircularProgressIndicator()
              : isLoggedIn
                  ? Profile(
                      logoutAction,
                      name == null ? "" : name as String,
                      picture == null ? "" : picture as String,
                      email == null ? "" : email as String)
                  : Login(loginAction,
                      errorMessage == null ? "" : errorMessage as String),
        ),
      ),
    );
  }

  Map<String, dynamic> parseIdToken(String idToken) {
    final parts = idToken.split(r'.');
    assert(parts.length == 3);

    return jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
  }

  Future<Map<String, dynamic>> getUserDetails(String accessToken) async {
    final url = 'https://$AUTH0_DOMAIN/userinfo';
    final response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get user details');
    }
  }

  Future<void> loginAction() async {
    setState(() {
      isBusy = true;
      errorMessage = '';
    });

    try {
      final AuthorizationTokenResponse? result =
          await appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(AUTH0_CLIENT_ID, AUTH0_REDIRECT_URI,
            issuer: 'https://$AUTH0_DOMAIN',
            scopes: ['openid', 'profile', 'offline_access', 'email'],
            promptValues: ['login']),
      );
      print(result.toString());
      final idToken = parseIdToken(result?.idToken as String);
      final profile = await getUserDetails(result?.accessToken as String);

      await secureStorage.write(
          key: 'refresh_token', value: result?.refreshToken);

      setState(() {
        isBusy = false;
        isLoggedIn = true;
        name = idToken['name'];
        email = idToken['email'];
        picture = profile['picture'];
      });
    } catch (e, s) {
      print('login error: $e - stack: $s');

      setState(() {
        isBusy = false;
        isLoggedIn = false;
        errorMessage = e.toString();
      });
    }
  }

  void logoutAction() async {
    await secureStorage.delete(key: 'refresh_token');
    setState(() {
      isLoggedIn = false;
      isBusy = false;
    });
  }

  @override
  void initState() {
    initAction();
    super.initState();
  }

  void initAction() async {
    final storedRefreshToken = await secureStorage.read(key: 'refresh_token');
    if (storedRefreshToken == null) return;

    setState(() {
      isBusy = true;
    });

    try {
      final response = await appAuth.token(TokenRequest(
        AUTH0_CLIENT_ID,
        AUTH0_REDIRECT_URI,
        issuer: AUTH0_ISSUER,
        refreshToken: storedRefreshToken,
      ));

      final idToken = parseIdToken(response?.idToken as String);
      final profile = await getUserDetails(response?.accessToken as String);
      print("Profile $profile");
      secureStorage.write(key: 'refresh_token', value: response?.refreshToken);

      setState(() {
        isBusy = false;
        isLoggedIn = true;
        name = idToken['name'];
        email = idToken['email'];
        picture = profile['picture'];
      });
    } catch (e, s) {
      print('error on refresh token: $e - stack: $s');
      logoutAction();
    }
  }
}
