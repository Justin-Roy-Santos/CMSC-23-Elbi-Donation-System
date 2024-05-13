import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    required this.onButtonPress,
    required this.bgColor,
    required this.buttonLabel,
    required this.textColor,
    super.key,
  });

  // properties
  final void Function() onButtonPress;
  final Color bgColor;
  final String buttonLabel;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: ElevatedButton(
        onPressed: onButtonPress,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: textColor,
        ),
        child: Text(buttonLabel),
      ),
    );
  }
}
