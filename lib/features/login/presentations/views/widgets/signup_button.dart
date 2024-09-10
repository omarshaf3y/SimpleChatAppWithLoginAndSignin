import 'package:flutter/material.dart';

class SignUpButton extends StatelessWidget {
  final String textButton;
  final Icon icon;
  final Color buttonColor;
  final Color textButtonColor;
  const SignUpButton({
    super.key,
    required this.textButton,
    required this.icon,
    required this.buttonColor,
    required this.textButtonColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 53.49,
      width: 417.21,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 21.4),
            Text(
              textButton,
              style: TextStyle(
                color: textButtonColor,
                fontSize: 23.53,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
