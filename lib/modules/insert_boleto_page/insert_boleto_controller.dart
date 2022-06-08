import 'package:flutter/material.dart';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InsertBoletoController {
  final formKey = GlobalKey<FormState>();
  BoletoModel boletoModel = BoletoModel();

  String? validateName(String? value) =>
      value?.isEmpty ?? true ? "O nome não pode ser vazio" : null;
  String? validateVencimento(String? value) =>
      value?.isEmpty ?? true ? "A data de vencimento não pode ser vazia" : null;
  String? validateValor(double value) =>
      value == 0 ? "Insira um valor maior que R\$ 0,00" : null;
  String? validateCodigo(String? value) =>
      value?.isEmpty ?? true ? "O código do boleto não pode ser vazio" : null;

  void onChange({
    String? name,
    String? dueDate,
    double? value,
    String? barcode,
  }) {
    boletoModel = boletoModel.copyWith(
      name: name,
      dueDate: dueDate,
      value: value,
      barcode: barcode,
    );
  }

  Future<void> saveBoleto() async {
    try {
      final instance = await SharedPreferences.getInstance();
      final boletos = instance.getStringList('boletos') ?? <String>[];
      boletos.add(boletoModel.toJson());

      await instance.setStringList('boletos', boletos);
      return;
    } catch (error) {
      print(error);
    }
  }

  Future<void> registerBoleto() async {
    final form = formKey.currentState;

    if (form!.validate()) {
      return await saveBoleto();
    }
  }
}
