import 'package:flay_app/common/bloc/button/button_state_cubit.dart';
import 'package:flay_app/core/configs/themes/app_colors.dart';
import 'package:flay_app/data/auth/models/user_signin_req.dart';
import 'package:flay_app/domain/auth/usecases/signin.dart';
import 'package:flay_app/presentation/home/pages/navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/bloc/button/button_state.dart';
import '../../../common/helper/navigator/app_navigator.dart';
import '../../../common/widgets/button/reactive_button.dart';
import '../../../core/configs/assets/app_vectors.dart';
import 'signup_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool emailValid = true;
  bool passwordValid = true;
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final _passwordRegex = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$',
  );

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (!_passwordRegex.hasMatch(value)) {
      return 'Password must be ≥8 chars,\ninclude uppercase, lowercase, number & special char';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Enter a valid email';
    }
    return null;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ButtonStateCubit(),

      child: BlocListener<ButtonStateCubit, ButtonState>(
        listener: (context, state) {
          if (state is ButtonSuccessState) {
            // on successful Login, navigate to your main screen:
            AppNavigator.pushAndRemove(context, const NavigationScreen());
          } else if (state is ButtonFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.primary,
                content: Text(
                  state.errorMessage,
                  style: TextStyle(color: AppColors.background),
                ),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        child: Scaffold(
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
                      // —— Logo
                      Center(
                        child: SvgPicture.asset(
                          AppVectors.flayBlack,
                          width: MediaQuery.of(context).size.width * 0.7,
                        ),
                      ),

                      const SizedBox(height: 24),
                      const Text(
                        'Welcome!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'please login or sign up to continue our app',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 32),
                      // —— Email field
                      _buildLabel("Email"),
                      const SizedBox(height: 8),
                      _buildEmailField(),

                      const SizedBox(height: 24),
                      // —— Password field
                      _buildLabel('Password'),
                      const SizedBox(height: 8),
                      _buildPasswordField(),
                      const SizedBox(height: 12),

                      // Forgot Password link
                      _buildForgotPasswordLink(),
                      const SizedBox(height: 40),
                      // —— Login button
                      _buildLoginButton(context),

                      const SizedBox(height: 16),
                      // —— OR separator
                      _buildOrField(),

                      const SizedBox(height: 16),
                      // —— Google sign-in
                      _buildGoogleButton(),
                      // Sign Up prompt
                      _buildSignUpPrompt(),
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

  Widget _buildGoogleButton() => SizedBox(
    width: double.infinity,
    height: 50,
    child: OutlinedButton.icon(
      onPressed: () {},
      icon: SvgPicture.asset(AppVectors.google, width: 24),
      label: const Text(
        'Continue with Google',
        style: TextStyle(fontSize: 16, color: Colors.black54),
      ),
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        side: const BorderSide(color: Colors.black12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    ),
  );
  Widget _buildSignUpPrompt() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text(
        "Don't have an account? ",
        style: TextStyle(color: Colors.grey),
      ),
      TextButton(
        onPressed: () {
          AppNavigator.push(context, SignupScreen());
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: const Size(50, 30),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: const Text(
          'Create one',
          style: TextStyle(
            color: AppColors.kBlueColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
  Widget _buildEmailField() => TextFormField(
    controller: emailController,
    style: const TextStyle(color: AppColors.primary),
    decoration: InputDecoration(
      hint: Text(
        'amiara414@gmail.com',
        style: TextStyle(color: AppColors.kHintStyle),
      ),
      hintStyle: TextStyle(color: AppColors.kHintStyle),
      contentPadding: const EdgeInsets.only(bottom: 6),
      suffixIcon: emailValid
          ? const Icon(Icons.check_circle, color: Colors.black, size: 24)
          : null,
      border: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.lineColor),
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.lineColor),
      ),
    ),
    keyboardType: TextInputType.emailAddress,
    validator: validateEmail,
    onChanged: (value) {
      setState(() {
        emailValid = value.contains('@');
      });
    },
  );
  Widget _buildOrField() => Row(
    children: const [
      Expanded(child: Divider(color: AppColors.lineColor)),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Text('or', style: TextStyle(color: Colors.grey)),
      ),
      Expanded(child: Divider(color: AppColors.lineColor)),
    ],
  );
  Widget _buildLoginButton(BuildContext context) {
    return Center(
      child: Builder(
        builder: (context) {
          return BasicReactiveButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                UserSigninReq userSigninReq = UserSigninReq(
                  email: emailController.text.trim(),
                  password: passwordController.text.trim(),
                );
                context.read<ButtonStateCubit>().execute(
                  usecase: SigninUsecase(),
                  params: userSigninReq,
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
            title: 'Login',
          );
        },
      ),
    );
  }

  Widget _buildForgotPasswordLink() => Align(
    alignment: Alignment.centerRight,
    child: TextButton(
      onPressed: () {
        AppNavigator.push(context, ForgotPasswordScreen());
      },
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: const Size(50, 30),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child:  Text(
        'Forgot Password? Reset',
        style: TextStyle(
          color: AppColors.kBlueColor, 
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
  Widget _buildLabel(String label) => Align(
    alignment: Alignment.centerLeft,
    child: Text(
      label,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: AppColors.primary,
      ),
    ),
  );
  Widget _buildPasswordField() => TextFormField(
    controller: passwordController,
    obscureText: true,
    style: const TextStyle(color: AppColors.primary),
    decoration: InputDecoration(
      hint: Text(
        '****************',
        style: TextStyle(color: AppColors.kHintStyle),
      ),
      isDense: true,
      hintStyle: TextStyle(color: AppColors.kHintStyle),
      contentPadding: const EdgeInsets.only(bottom: 6),
      suffixIcon: passwordValid
          ? const Icon(Icons.check_circle, color: Colors.black, size: 24)
          : null,
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.lineColor),
      ),
    ),
    validator: validatePassword,
    onChanged: (value) {
      setState(() {
        passwordValid = value.length > 8;
      });
    },
  );
}