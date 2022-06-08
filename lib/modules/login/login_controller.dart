import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:payflow/shared/auth/auth_cotroller.dart';
import 'package:payflow/shared/models/user_model.dart';

class LoginController {
  final authController = AuthController();

  Future<void> handleGoogleSignIn(BuildContext context, bool mounted) async {
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );

    try {
      final response = await googleSignIn.signIn();
      final user = UserModel(name: response!.displayName!, photoUrl: response.photoUrl);

      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return;

      authController.setUser(context, user);
    } catch (error) {
      authController.setUser(context, null);
    }
  }
}
