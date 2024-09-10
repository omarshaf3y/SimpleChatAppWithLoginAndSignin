import 'package:flutter/material.dart';

class PassTextFormField extends StatelessWidget {
  final bool isPasswordVisible;
  final VoidCallback onToggleVisibility;
  final Function(String)? onChanged;
  const PassTextFormField(
      {super.key,
      required this.isPasswordVisible,
      required this.onToggleVisibility,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (data) {
        if (data!.isEmpty) {
          return 'Field is required';
        }
        return null;
      },
      onChanged: onChanged,
      obscureText: !isPasswordVisible,
      decoration: InputDecoration(
        hintText: 'Password',
        suffixIcon: IconButton(
          icon: Icon(
            isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: const Color(0xffBABABA),
          ),
          onPressed: onToggleVisibility,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
