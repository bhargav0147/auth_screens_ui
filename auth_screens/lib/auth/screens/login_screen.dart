import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

import '../../utils/app_colors.dart';
import '../../utils/styles/text_field_style.dart';
import '../../utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.controller});
  final PageController controller;
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox.fromSize(
        size: MediaQuery.sizeOf(context),
        child: Stack(
          children: [          
            Positioned(
              bottom: 30,
              left: 30,
              right: 30,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.whiteColor.withOpacity(.8),
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                   
                    children: [
                      Text(
                        'Log In',
                        style: TextStyle(
                          color: AppColors.primaryHighContrast,
                          fontSize: 27,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter you e-mail.";
                          } else if (!isEmail(value)) {
                            return "Invalid mail";
                          }
                          return null;
                        },
                        controller: _emailController,
                        style: textFieldTextStyle(),
                        decoration: textFieldDecoration('Email'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter you password";
                          } else if (value.length < 6) {
                            return "Must have at least 6 chars";
                          }
                          return null;
                        },
                        focusNode: FocusNode(
                          canRequestFocus: true,
                        ),
                        controller: _passController,
                        style: textFieldTextStyle(),
                        decoration: textFieldDecoration('Password'),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      FractionallySizedBox(
                        widthFactor: 1,
                        child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              foregroundColor: AppColors.whiteColor,
                            ),
                            onPressed: () async {
                              loadingDialog(context);
                              FocusManager.instance.primaryFocus?.unfocus();
                              Future.delayed(const Duration(seconds: 2)).then(
                                (value) => Navigator.pop(context),
                              );
                            },
                            child: const Text("Sign In")),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          
                          Text(
                            'Don’t have an account?',
                            style: TextStyle(
                              color: AppColors.darkGrey,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            width: 2.5,
                          ),
                          InkWell(
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              widget.controller.animateToPage(1,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.ease);
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Forget Password?',
                        style: TextStyle(
                          color: AppColors.primaryHighContrast,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
