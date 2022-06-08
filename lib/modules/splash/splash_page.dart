import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_images.dart';

import '../../shared/auth/auth_cotroller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authController = AuthController();
    authController.hasSignedUser(context);

    return Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
          children: <Widget>[
            Center(child: Image.asset(AppImages.union)),
            Center(child: Image.asset(AppImages.logoFull)),
          ],
        ));
  }
}
