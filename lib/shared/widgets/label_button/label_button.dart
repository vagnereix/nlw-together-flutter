import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';

class LabelButtonProps {
  final String label;
  final VoidCallback onPressed;

  final bool hasPrimaryColor;

  const LabelButtonProps({
    required this.label,
    required this.onPressed,
    this.hasPrimaryColor = false,
  }) : super();
}

class LabelButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  final bool hasPrimaryColor;

  const LabelButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.hasPrimaryColor = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(
          top: BorderSide(
            color: AppColors.stroke,
            width: 1,
          ),
        ),
      ),
      height: 55,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          label,
          style: hasPrimaryColor
              ? TextStyles.buttonPrimary
              : TextStyles.buttonHeading,
        ),
      ),
    );
  }
}
