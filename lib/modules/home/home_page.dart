import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:payflow/modules/my_boletos/my_boletos.dart';
import 'package:payflow/modules/paid_boletos/paid_boletos.dart';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:payflow/shared/models/user_model.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/widgets/boleto_info/boleto_info.dart';
import 'package:payflow/shared/widgets/boleto_list/boleto_list_controller.dart';

import '../../shared/themes/app_text_styles.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final UserModel user;

  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = HomeController();
  final boletosController = BoletoListController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 200,
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0, 2),
                  radius: 1.1,
                  colors: <Color>[
                    AppColors.background,
                    AppColors.primary,
                  ],
                  // stops: <double>[0.4, 1.0],
                ),
              ),
              child: Center(
                child: ListTile(
                  title: Text.rich(
                    TextSpan(
                      text: 'Olá, ',
                      style: TextStyles.titleRegular,
                      children: [
                        TextSpan(
                          text: widget.user.name,
                          style: TextStyles.titleBoldBackground,
                        ),
                      ],
                    ),
                  ),
                  subtitle: Text(
                    'Mantenha suas contas em dia',
                    style: TextStyles.captionShape,
                  ),
                  trailing: Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(
                          widget.user.photoUrl!,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ValueListenableBuilder<List<BoletoModel>>(
              valueListenable: boletosController.boletosNotifier,
              builder: (context, boletos, widget) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Transform.translate(
                  offset: const Offset(0.0, 40),
                  child: BoletoInfo(size: boletos.length),
                ),
              ),
            ),
          ],
        ),
      ),
      body: [
        MyBoletos(
          key: UniqueKey(),
        ),
        PaidBoletos(
          key: UniqueKey(),
        ),
      ][homeController.currentPage],
      bottomNavigationBar: Container(
        height: 76,
        decoration: const BoxDecoration(
          color: Colors.transparent,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -35),
              blurRadius: 30,
              color: AppColors.background,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            AnimatedCard(
              direction: AnimatedCardDirection.bottom,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    homeController.setPage(0);
                  });
                },
                icon: Icon(
                  Icons.home,
                  color: homeController.currentPage == 0
                      ? AppColors.primary
                      : AppColors.body,
                ),
              ),
            ),
            AnimatedCard(
              direction: AnimatedCardDirection.bottom,
              initDelay: const Duration(milliseconds: 1000),
              child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: IconButton(
                  onPressed: () async {
                    await Navigator.pushNamed(context, '/barcode_scanner');
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.add_box_outlined,
                    color: AppColors.background,
                  ),
                ),
              ),
            ),
            AnimatedCard(
              direction: AnimatedCardDirection.bottom,
              child: IconButton(
                onPressed: () {
                  homeController.setPage(1);
                  setState(() {});
                },
                icon: Icon(
                  Icons.description_outlined,
                  color: homeController.currentPage == 1
                      ? AppColors.primary
                      : AppColors.body,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
