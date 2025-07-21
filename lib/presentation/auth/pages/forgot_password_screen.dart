import 'package:flay_app/common/helper/navigator/app_navigator.dart';
import 'package:flay_app/common/widgets/appbar.dart';
import 'package:flay_app/presentation/auth/pages/login_screen.dart';
import 'package:flutter/material.dart';

import '../../../core/configs/themes/app_colors.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool emailValid = true;
  bool passwordValid = true;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),

                  const SizedBox(height: 24),
                  const Text(
                    'Forgot Password !',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Enter Your email Address',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 32),
                  // —— Email field
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Email',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    style: const TextStyle(color: AppColors.primary),
                    decoration: InputDecoration(
                      hint: Text(
                        'abc@gmail.com',
                        style: TextStyle(color: AppColors.kHintStyle),
                      ),
                      hintStyle: TextStyle(color: AppColors.kHintStyle),
                      contentPadding: const EdgeInsets.only(bottom: 6),
                      suffixIcon: emailValid
                          ? const Icon(
                              Icons.check_circle,
                              color: Colors.black,
                              size: 24,
                            )
                          : null,
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lineColor),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lineColor),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      setState(() {
                        emailValid = value.contains('@');
                      });
                    },
                  ),

                  const SizedBox(height: 24),

                  const SizedBox(height: 12),

                  const SizedBox(height: 40),
                  // —— Login button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          // All good!
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Password is strong ✅'),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        ' Send ',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                  // —— OR separator
                  Row(
                    children: const [
                      Expanded(child: Divider(color: AppColors.lineColor)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text('or', style: TextStyle(color: Colors.grey)),
                      ),
                      Expanded(child: Divider(color: AppColors.lineColor)),
                    ],
                  ),

                  // Sign Up prompt
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("", style: TextStyle(color: Colors.grey)),
                      TextButton(
                        onPressed: () {
                          AppNavigator.push(
                            context, LoginScreen(),
                          
                          );
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(50, 30),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          'Back to Signin ',
                          style: TextStyle(
                            color: AppColors.kHintStyle, // or AppColors.accent
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
