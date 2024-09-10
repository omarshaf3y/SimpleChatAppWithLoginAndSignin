import 'package:chatapp/features/register/presentations/views/register_view.dart';
import 'package:flutter/material.dart';

class HaveAccountWidget extends StatelessWidget {
  const HaveAccountWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account? ",
          style: TextStyle(
            fontSize: 16.26,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const RegisterView();
            }));
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(
              fontSize: 16.26,
              fontWeight: FontWeight.bold,
              color: Color(0xff0098FF),
              decoration: TextDecoration.underline,
              decorationColor: Color(0xff0098FF),
            ),
          ),
        ),
      ],
    );
  }
}
