import 'package:flutter/material.dart';

import '../divider_vertical/divider_vertical.dart';
import '../label_button/label_button.dart';

class SetLabelButtons extends StatelessWidget {
  final LabelButtonProps primaryButton;
  final LabelButtonProps secondaryButton;

  const SetLabelButtons({
    Key? key,
    required this.primaryButton,
    required this.secondaryButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: LabelButton(
            label: primaryButton.label,
            onPressed: primaryButton.onPressed,
            hasPrimaryColor: primaryButton.hasPrimaryColor,
          ),
        ),
        const DividerVertical(),
        Expanded(
          child: LabelButton(
            label: secondaryButton.label,
            onPressed: secondaryButton.onPressed,
            hasPrimaryColor: secondaryButton.hasPrimaryColor,
          ),
        ),
      ],
    );
  }
}
