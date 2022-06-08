import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/label_button/label_button.dart';
import 'package:payflow/shared/widgets/set_label_buttons/set_label_buttons.dart';

class BottomSheetWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  final LabelButtonProps primaryButton;
  final LabelButtonProps secondaryButton;

  const BottomSheetWidget({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.primaryButton,
    required this.secondaryButton, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RotatedBox(
        quarterTurns: 1,
        child: Material(
          child: Container(
            color: AppColors.shape,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.black.withOpacity(0.8),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(40),
                      child: Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(
                          text: title,
                          style: TextStyles.buttonBoldHeading,
                          children: [
                            const TextSpan(
                              text: '\n',
                            ),
                            TextSpan(
                              text: subtitle,
                              style: TextStyles.buttonHeading,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SetLabelButtons(
                      primaryButton: primaryButton,
                      secondaryButton: secondaryButton,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
