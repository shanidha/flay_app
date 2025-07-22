import 'package:flay_app/common/bloc/button/button_state_cubit.dart';
import 'package:flay_app/common/helper/navigator/app_navigator.dart';
import 'package:flay_app/common/widgets/appbar.dart';
import 'package:flay_app/domain/auth/usecases/send_password_email.dart';
import 'package:flay_app/presentation/auth/pages/login_screen.dart';
import 'package:flay_app/presentation/auth/pages/success_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/bloc/button/button_state.dart';
import '../../../common/widgets/button/reactive_button.dart';
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
        child: BlocProvider(
          create: (context) => ButtonStateCubit(),
          child: BlocListener<ButtonStateCubit, ButtonState>(
            listener: (context, state) {
              if (state is ButtonFailureState) {
                var snackbar = SnackBar(backgroundColor: AppColors.primary,
                  content: Text(state.errorMessage,style: TextStyle(color: AppColors.background),),
                  behavior: SnackBarBehavior.floating,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
              }

              if (state is ButtonSuccessState) {
                AppNavigator.push(
                  context,
                   SuccessPage(
                    message: "We send you Email to reset your Password",
                    onPressed: () {
                      AppNavigator.pushAndRemove(context, LoginScreen());
                    },
                    title: 'Return To Login',
                  ),
                );
              }
            },

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
                        controller: emailController,
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

                      const SizedBox(height: 80),

                      // —— Send button
                      _buildSendButton(),
                      const SizedBox(height: 16),
                      // —— OR separator
                      Row(
                        children: const [
                          Expanded(child: Divider(color: AppColors.lineColor)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              'or',
                              style: TextStyle(color: Colors.grey),
                            ),
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
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(50, 30),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text(
                              'Back to Signin ',
                              style: TextStyle(
                                color: AppColors.kHintStyle,
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
        ),
      ),
    );
  }

  Widget _buildSendButton() => Center(
    child: Builder(
      builder: (context) {
        return BasicReactiveButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              context.read<ButtonStateCubit>().execute(
                usecase: SendPasswordResetEmailUseCase(),
                params: emailController.text,
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: AppColors.primary,
                  content: Text(
                    "Please fill all the details",
                    style: TextStyle(color: AppColors.background),
                  ),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          title: 'Send',
        );
      },
    ),
  );
}
