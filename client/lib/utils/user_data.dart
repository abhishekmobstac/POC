import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static final storage = FlutterSecureStorage();

  static const keyUserdata = 'userdata';

  static Future setUserdata(List<String> userdata) async {
    final userValue = json.encode(userdata);
    await storage.write(key: keyUserdata, value: userValue);
  }

  static Future getUserdata() async {
    final value = await storage.read(key: keyUserdata);
    return value == null ? null : List<String>.from(json.decode(value));
  }

  static Future deleteUserdata() async {
    await storage.delete(key: keyUserdata);
  }
}
