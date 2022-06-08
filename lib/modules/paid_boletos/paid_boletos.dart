import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/boleto_list/boleto_list.dart';
import 'package:payflow/shared/widgets/boleto_list/boleto_list_controller.dart';

class PaidBoletos extends StatefulWidget {
  const PaidBoletos({Key? key}) : super(key: key);

  @override
  State<PaidBoletos> createState() => _PaidBoletosState();
}

class _PaidBoletosState extends State<PaidBoletos> {
  final boletosController = BoletoListController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ValueListenableBuilder<List<BoletoModel>>(
        valueListenable: boletosController.boletosNotifier,
        builder: (context, boletos, widget) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 70),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Meus extratos',
                      style: TextStyles.titleBoldHeading,
                    ),
                    AnimatedCard(
                      direction: AnimatedCardDirection.right,
                      initDelay: const Duration(milliseconds: 500),
                      child: Text(
                        '${boletos.length} ao total',
                        style: TextStyles.captionBody,
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Divider(
                  color: AppColors.stroke,
                ),
              ),
              const BoletoList(),
            ],
          ),
        ),
      ),
    );
  }
}
