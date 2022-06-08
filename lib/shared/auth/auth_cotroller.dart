import 'package:flutter/material.dart';
import 'package:payflow/shared/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  bool isAuthenticated = false;
  UserModel? myUser;

  UserModel get user => myUser!;

  void setUser(BuildContext context, UserModel? user) {
    if (user != null) {
      myUser = user;
      saveUser(user);
      isAuthenticated = true;

      Navigator.pushReplacementNamed(context, '/home', arguments: user);
    } else {
      isAuthenticated = false;

      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  Future<void> saveUser(UserModel user) async {
    final instance = await SharedPreferences.getInstance();
    await instance.setString('user', user.toJson());

    return;
  }

  Future<void> hasSignedUser(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 1500));

    final instance = await SharedPreferences.getInstance();
    // instance.remove('boletos');

    if (instance.containsKey('user')) {
      final user = instance.get('user') as String;

      setUser(context, UserModel.fromJson(user));
      return;
    } else {
      setUser(context, null);
    }
  }
}
