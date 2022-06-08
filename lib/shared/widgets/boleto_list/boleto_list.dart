import 'package:flutter/material.dart';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:payflow/shared/widgets/boleto_list/boleto_list_controller.dart';

import '../boleto_tile/boleto_tile.dart';

class BoletoList extends StatefulWidget {
  const BoletoList({Key? key}) : super(key: key);

  @override
  State<BoletoList> createState() => _BoletoListState();
}

class _BoletoListState extends State<BoletoList> {
  final controller = BoletoListController();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<BoletoModel>>(
      valueListenable: controller.boletosNotifier,
      builder: (context, boletos, widget) => Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          children: boletos.map((boleto) => BoletoTile(data: boleto)).toList(),
        ),
      ),
    );
  }
}
