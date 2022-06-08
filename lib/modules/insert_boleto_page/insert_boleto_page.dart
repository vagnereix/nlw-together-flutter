import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:payflow/modules/barcode_scanner/barcode_scanner_controller.dart';
import 'package:payflow/modules/insert_boleto_page/insert_boleto_controller.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/input_text/input_text.dart';
import 'package:payflow/shared/widgets/label_button/label_button.dart';
import 'package:payflow/shared/widgets/set_label_buttons/set_label_buttons.dart';

class InsertBoletoPage extends StatefulWidget {
  final String? barcode;

  const InsertBoletoPage({Key? key, this.barcode}) : super(key: key);

  @override
  State<InsertBoletoPage> createState() => _InsertBoletoPageState();
}

class _InsertBoletoPageState extends State<InsertBoletoPage> {
  final insertBoletoController = InsertBoletoController();
  final barcodeScannerController = BarcodeScannerController();

  final moneyInputController = MoneyMaskedTextController(
      leftSymbol: "R\$", decimalSeparator: ',', thousandSeparator: '.');
  final dueDateInputController = MaskedTextController(mask: "00/00/0000");
  final barcodeInputController = TextEditingController();

  late final List<LabelButtonProps> bottomNavigationButtons;

  @override
  initState() {
    if (widget.barcode != null) {
      barcodeInputController.text = widget.barcode!;
    }

    final cancel = LabelButtonProps(
      label: 'Cancelar',
      onPressed: () async {
        Navigator.pop(context);
        barcodeScannerController.scanWithCamera();
      },
    );

    final register = LabelButtonProps(
      label: 'Cadastrar',
      hasPrimaryColor: true,
      onPressed: () async {
        await insertBoletoController.registerBoleto();

        await Future.delayed(const Duration(seconds: 1));
        if (!mounted) return;

        Navigator.pushReplacementNamed(context, '/splash');
      },
    );

    bottomNavigationButtons = [cancel, register];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: const BackButton(color: AppColors.input),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 90, vertical: 20),
                child: Text(
                  'Preencha os dados do boleto',
                  style: TextStyles.titleBoldHeading,
                  textAlign: TextAlign.center,
                ),
              ),
              Form(
                key: insertBoletoController.formKey,
                child: Column(
                  children: [
                    InputText(
                      label: 'Nome do boleto',
                      icon: Icons.description_outlined,
                      validator: insertBoletoController.validateName,
                      onChanged: (value) {
                        insertBoletoController.onChange(name: value);
                      },
                    ),
                    InputText(
                      label: 'Vencimento',
                      controller: dueDateInputController,
                      validator: insertBoletoController.validateVencimento,
                      icon: FontAwesomeIcons.circleXmark,
                      onChanged: (value) {
                        insertBoletoController.onChange(dueDate: value);
                      },
                    ),
                    InputText(
                      label: 'Valor',
                      controller: moneyInputController,
                      validator: (value) => insertBoletoController
                          .validateValor(moneyInputController.numberValue),
                      icon: FontAwesomeIcons.wallet,
                      onChanged: (value) {
                        insertBoletoController.onChange(
                            value: moneyInputController.numberValue);
                      },
                    ),
                    InputText(
                      label: 'Código',
                      controller: barcodeInputController,
                      validator: insertBoletoController.validateCodigo,
                      icon: FontAwesomeIcons.barcode,
                      onChanged: (value) {
                        insertBoletoController.onChange(barcode: value);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SetLabelButtons(
        primaryButton: bottomNavigationButtons[0],
        secondaryButton: bottomNavigationButtons[1],
      ),
    );
  }
}
