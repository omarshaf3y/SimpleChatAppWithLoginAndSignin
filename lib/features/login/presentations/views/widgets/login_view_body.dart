import 'package:chatapp/core/widgets/custom_snackbar.dart';
import 'package:chatapp/features/chat/presentations/views/chat_view.dart';
import 'package:chatapp/features/login/presentations/views/widgets/custom_button.dart';
import 'package:chatapp/features/login/presentations/views/widgets/forget_text.dart';
import 'package:chatapp/features/login/presentations/views/widgets/have_account.dart';
import 'package:chatapp/features/login/presentations/views/widgets/signup_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'custom_divider.dart';
import 'email_text_field.dart';
import 'password_text_field.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  bool _isPasswordVisible = false;
  String? email;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/cover.png',
        ),
        const SizedBox(height: 32.9),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21.4),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Text(
                  'Let’s Connect With Us!',
                  style: TextStyle(
                    fontSize: 32.09,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32.23),
                CustomTextFormField(
                  onChanged: (data) {
                    email = data;
                  },
                  label: 'Email Address',
                  hintText: 'Email',
                  icon: const Icon(
                    Icons.email,
                    color: Color(0xffBABABA),
                  ),
                ),
                const SizedBox(height: 21.4),
                PassTextFormField(
                  onChanged: (data) {
                    password = data;
                  },
                  isPasswordVisible: _isPasswordVisible,
                  onToggleVisibility: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
                const SizedBox(height: 10.2),
                const ForgetText(),
                const SizedBox(height: 32.42),
                CustomButton(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      try {
                        await loginUser();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const ChatView();
                            },
                          ),
                        );
                      } on FirebaseAuthException catch (ex) {
                        handleFirebaseException(ex);
                      }
                    }
                  },
                  textButton: 'Login',
                ),
                const SizedBox(height: 20.35),
                const CustomDivider(),
                const SizedBox(height: 20.35),
                const SignUpButton(
                  textButton: 'Sign up with Apple',
                  icon: Icon(
                    size: 35,
                    Icons.apple,
                    color: Colors.white,
                  ),
                  buttonColor: Colors.black,
                  textButtonColor: Colors.white,
                ),
                const SizedBox(height: 10.35),
                const SignUpButton(
                  textButton: 'Sign up with Google',
                  icon: Icon(
                    size: 35,
                    Icons.mail,
                    color: Colors.black,
                  ),
                  buttonColor: Colors.white,
                  textButtonColor: Colors.black,
                ),
                const SizedBox(height: 15.35),
                const HaveAccountWidget(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> loginUser() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }

  void handleFirebaseException(FirebaseAuthException ex) {
    String errorMessage;

    if (ex.code == 'wrong-password') {
      errorMessage = 'Incorrect password. Please try again.';
    } else if (ex.code == 'user-not-found') {
      errorMessage = 'No user found with this email.';
    } else {
      errorMessage = 'An error occurred. Please try again.';
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        elevation: 6.0,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        duration: const Duration(seconds: 4),
        content: CustomSnackBar(
          scaffoldMessengerText: errorMessage,
          icon: Icons.error_outline,
        ),
      ),
    );
  }
}
