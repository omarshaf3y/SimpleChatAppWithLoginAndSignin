import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String textButton;

  final VoidCallback onTap;
  const CustomButton({
    super.key,
    required this.textButton,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 53.49,
        width: 417.21,
        decoration: BoxDecoration(
          color: const Color(0xff0098FF),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            textButton,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26.74,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
