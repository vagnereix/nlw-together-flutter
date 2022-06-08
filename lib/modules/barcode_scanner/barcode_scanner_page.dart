import 'package:flutter/material.dart';
import 'package:payflow/modules/barcode_scanner/barcode_scanner_controller.dart';
import 'package:payflow/modules/barcode_scanner/barcode_scanner_status.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/widgets/bottom_sheet_widget/bottom_sheet_widget.dart';
import 'package:payflow/shared/widgets/label_button/label_button.dart';
import 'package:payflow/shared/widgets/set_label_buttons/set_label_buttons.dart';

import '../../shared/themes/app_text_styles.dart';

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({Key? key}) : super(key: key);

  @override
  State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  final barcodeScannerController = BarcodeScannerController();

  late final List<LabelButtonProps> barcodeScannerButtons;
  late final List<LabelButtonProps> bottomSheetButtons;

  @override
  void initState() {
    barcodeScannerController.getAvailableCameras();
    barcodeScannerController.statusNotifier.addListener(() {
      if (barcodeScannerController.status.hasBarcode) {
        Navigator.pushReplacementNamed(context, '/insert_boleto',
            arguments: barcodeScannerController.status.barcode);
      }
    });

    final scanAgain = LabelButtonProps(
      label: 'Escanear novamente',
      hasPrimaryColor: true,
      onPressed: () {
        barcodeScannerController.scanWithCamera();
      },
    );
    final typeCode = LabelButtonProps(
      label: 'Digitar código',
      onPressed: () {
        Navigator.pushNamed(context, '/insert_boleto');
      },
    );

    final insertCode = LabelButtonProps(
      label: 'Inserir código do boleto',
      onPressed: () {
        Navigator.pushNamed(context, '/insert_boleto');
      },
    );
    final addForGallery = LabelButtonProps(
      label: 'Adicionar da galeria',
      onPressed: () {
        barcodeScannerController.scanWithImagePicker();
      },
    );

    barcodeScannerButtons = [insertCode, addForGallery];
    bottomSheetButtons = [scanAgain, typeCode];
    super.initState();
  }

  @override
  void dispose() {
    barcodeScannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          ValueListenableBuilder<BarcodeScannerStatus>(
            valueListenable: barcodeScannerController.statusNotifier,
            builder: (context, status, widget) {
              if (status.showCamera) {
                return Container(
                  color: Colors.blue,
                  child:
                      barcodeScannerController.cameraController!.buildPreview(),
                );
              } else {
                return Container();
              }
            },
          ),
          RotatedBox(
            quarterTurns: 1,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.black,
                centerTitle: true,
                leading: const BackButton(color: AppColors.background),
                title: Text(
                  'Escaneie o código de barras do boleto',
                  style: TextStyles.buttonBackground,
                ),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: SetLabelButtons(
                primaryButton: barcodeScannerButtons[0],
                secondaryButton: barcodeScannerButtons[1],
              ),
            ),
          ),
          ValueListenableBuilder<BarcodeScannerStatus>(
            valueListenable: barcodeScannerController.statusNotifier,
            builder: (context, status, widget) {
              if (status.hasError) {
                return BottomSheetWidget(
                  title: 'Não foi possível identificar um código de barras.',
                  subtitle:
                      'Tente escanear novamente ou digite o código do seu boleto.',
                  primaryButton: bottomSheetButtons[0],
                  secondaryButton: bottomSheetButtons[1],
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
