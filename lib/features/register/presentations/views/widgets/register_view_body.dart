import 'package:chatapp/core/widgets/custom_snackbar.dart';
import 'package:chatapp/features/login/presentations/views/widgets/custom_button.dart';
import 'package:chatapp/features/login/presentations/views/widgets/custom_divider.dart';
import 'package:chatapp/features/login/presentations/views/widgets/email_text_field.dart';
import 'package:chatapp/features/login/presentations/views/widgets/forget_text.dart';
import 'package:chatapp/features/login/presentations/views/widgets/password_text_field.dart';
import 'package:chatapp/features/login/presentations/views/widgets/signup_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
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
                  'Sign Up To Talk!',
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
                        await registerUser();
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating,
                            elevation: 6.0,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            duration: const Duration(seconds: 4),
                            action: SnackBarAction(
                              label: 'Done',
                              textColor: Colors.white,
                              onPressed: () {
                                // Handle the retry action
                              },
                            ),
                            content: const CustomSnackBar(
                              scaffoldMessengerText:
                                  'Registration has been completed successfully.',
                              icon: Icons.done,
                            ),
                          ),
                        );
                      } on FirebaseAuthException catch (ex) {
                        if (ex.code == 'weak-password') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.redAccent,
                              behavior: SnackBarBehavior.floating,
                              elevation: 6.0,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              duration: const Duration(seconds: 4),
                              action: SnackBarAction(
                                label: 'Retry',
                                textColor: Colors.white,
                                onPressed: () {
                                  // Handle the retry action
                                },
                              ),
                              content: const CustomSnackBar(
                                scaffoldMessengerText: 'Weak Password',
                                icon: Icons.error_outline,
                              ),
                            ),
                          );
                          return; // Stop further execution if an error occurs
                        } else if (ex.code == 'email-already-in-use') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.redAccent,
                              behavior: SnackBarBehavior.floating,
                              elevation: 6.0,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              duration: const Duration(seconds: 4),
                              action: SnackBarAction(
                                label: 'Retry',
                                textColor: Colors.white,
                                onPressed: () {
                                  // Handle the retry action
                                },
                              ),
                              content: const CustomSnackBar(
                                scaffoldMessengerText: 'Email Already Exist',
                                icon: Icons.error_outline,
                              ),
                            ),
                          );
                          return;
                        }
                      }
                    } else {}
                  },
                  textButton: 'Sign up',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(
                        fontSize: 16.26,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Sign In",
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
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> registerUser() async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
