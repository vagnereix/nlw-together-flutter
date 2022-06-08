import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_images.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/social_login/social_login_button.dart';

import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(children: [
          Container(
            width: size.width,
            height: size.height * 0.36,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  AppColors.primary,
                  AppColors.primary,
                  AppColors.background
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: size.height * 0.05,
            child: Image.asset(AppImages.person, width: 208, height: 350),
          ),
          Positioned(
            bottom: size.height * 0.05,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.background,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, -size.height * 0.20),
                    blurRadius: 60,
                    color: AppColors.background,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Image.asset(AppImages.logomini),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 25, left: 70, right: 70),
                    child: Text(
                      'Organize seus boletos em um só lugar',
                      style: TextStyles.titleHome,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 35, right: 35),
                    child: SocialLoginButton(
                      onTap: () {
                        loginController.handleGoogleSignIn(context, mounted);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
