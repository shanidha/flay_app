import 'package:flay_app/core/common/helper/navigator/app_navigator.dart';
import 'package:flay_app/core/configs/themes/app_colors.dart';
import 'package:flay_app/features/auth/data/models/user_creation.dart';
import 'package:flay_app/features/auth/presentation/pages/login_screen.dart';
import 'package:flay_app/features/auth/presentation/pages/success_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/common/bloc/button/button_state.dart';
import '../../../../core/common/bloc/button/button_state_cubit.dart';
import '../../../../core/common/widgets/button/reactive_button.dart';
import '../../../../core/configs/assets/app_vectors.dart';
import '../../../../core/utils/validators.dart';
import '../../domain/usecases/signup.dart';
import '../../../home/presentation/pages/navigation_screen.dart';
import '../bloc/gender_selection.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool userValid = true, emailValid = true;
  bool passVisible = false, confirmVisible = false;
  bool isCheck = false;
  int isGender = 1;
  final TextEditingController _userNameCon = TextEditingController();
  final TextEditingController _emailCon = TextEditingController();
  final TextEditingController _passwordConfirmCon = TextEditingController();
  final TextEditingController _passwordCon = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _userNameCon.dispose();
    _emailCon.dispose();
    _passwordCon.dispose();
    _passwordConfirmCon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GenderSelectionCubit()),
        BlocProvider(create: (context) => ButtonStateCubit()),
      ],
      child: BlocListener<ButtonStateCubit, ButtonState>(
        listener: (context, state) {
          if (state is ButtonSuccessState) {
            // on successful signup, navigate to your main screen:
            AppNavigator.pushAndRemove(
              context,
              SuccessPage(
                title: 'Start Shopping',
                message:
                    'You have successfully registered in our app and start working in it.',
                onPressed: (ctx) {
                  if (!ctx.mounted) return;
                  Navigator.of(ctx).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const NavigationScreen()),
                    (route) => false,
                  );
                },
              ),
            );
          } else if (state is ButtonFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
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
                    children: [
                      const SizedBox(height: 40),
                      _buildLogo(),
                      const SizedBox(height: 24),
                      _buildHeader(),
                      const SizedBox(height: 8),
                      _buildTitle(),

                      const SizedBox(height: 32),
                      // User Name
                      _buildField(
                        controller: _userNameCon,
                        label: 'User Name',
                        initial: 'Amiara',
                        valid: userValid,
                        onChanged: (v) =>
                            setState(() => userValid = v.length >= 3),
                        validator: (v) =>
                            Validators.requiredMin(v, min: 3, label: 'Name'),
                      ),
                      const SizedBox(height: 24),
                      // Email
                      _buildField(
                        controller: _emailCon,
                        label: 'Email',
                        initial: 'amiara414@gmail.com',
                        valid: emailValid,
                        keyboard: TextInputType.emailAddress,
                        onChanged: (v) =>
                            setState(() => emailValid = v.contains('@')),
                        validator: Validators.email,
                      ),
                      const SizedBox(height: 24),
                      // Password
                      _buildField(
                        controller: _passwordCon,
                        label: 'Password',
                        initial: '****************',
                        suffix: IconButton(
                          icon: Icon(
                            color: AppColors.primary,
                            passVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () =>
                              setState(() => passVisible = !passVisible),
                        ),
                        obscure: !passVisible,
                        onChanged: (_) {},
                        validator: Validators.strongPassword,
                      ),
                      const SizedBox(height: 24),
                      // Confirm Password
                      _buildField(
                        controller: _passwordConfirmCon,
                        label: 'Confirm Password',
                        initial: '****************',
                        suffix: IconButton(
                          icon: Icon(
                            color: AppColors.primary,
                            confirmVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () =>
                              setState(() => confirmVisible = !confirmVisible),
                        ),
                        obscure: !confirmVisible,
                        onChanged: (_) {},
                        validator: (v) =>
                            Validators.confirmPassword(v, _passwordCon.text),
                      ),

                      const SizedBox(height: 24),
                      _genders(context),

                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Checkbox(
                            activeColor: AppColors.primary,
                            checkColor: AppColors.background,
                            value: isCheck,
                            onChanged: (value) {
                              setState(() {
                                isCheck = !isCheck;
                              });
                            },
                          ),
                          const Expanded(
                            child: Text(
                              'By creating an account you have to agree with our terms & conditions.',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),
                      // Sign Up button
                      _signupButton(context),
                      // Login  button
                      _buildLoginButton(),
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

  Widget _buildLoginButton() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text(
        "Already have an account? ",
        style: TextStyle(color: Colors.grey),
      ),
      TextButton(
        onPressed: () {
          AppNavigator.push(context, LoginScreen());
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: const Size(50, 30),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: const Text(
          'Login here',
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
  Widget _buildHeader() => const Align(
    alignment: Alignment.centerLeft,
    child: Text(
      'Sign Up',
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
      ),
    ),
  );
  Widget _buildLogo() => SvgPicture.asset(
    AppVectors.flayBlack,
    width: MediaQuery.of(context).size.width * 0.7,
  );
  Widget _genders(BuildContext context) {
    return BlocBuilder<GenderSelectionCubit, int>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            genderTile(context, 1, 'Men'),
            const SizedBox(width: 20),
            genderTile(context, 2, 'Women'),
          ],
        );
      },
    );
  }

  Widget _buildTitle() => const Align(
    alignment: Alignment.centerLeft,
    child: Text(
      'Create an new account',
      style: TextStyle(
        fontSize: 16,
        color: Colors.grey,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
  Expanded genderTile(BuildContext context, int genderIndex, String gender) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          context.read<GenderSelectionCubit>().selectGender(genderIndex);
        },
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primary),
            color:
                context.read<GenderSelectionCubit>().selectedIndex ==
                    genderIndex
                ? AppColors.primary
                : AppColors.background,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              gender,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color:
                    context.read<GenderSelectionCubit>().selectedIndex ==
                        genderIndex
                    ? AppColors.background
                    : AppColors.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    String? initial,
    bool valid = false,
    TextInputType keyboard = TextInputType.text,
    bool obscure = false,
    Widget? suffix,
    required ValueChanged<String> onChanged,
    FormFieldValidator<String>? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: 10),
        TextFormField(
          style: TextStyle(color: AppColors.primary),
          validator: validator,
          controller: controller,
          keyboardType: keyboard,
          obscureText: obscure,
          decoration: InputDecoration(
            hintStyle: TextStyle(color: AppColors.kHintStyle),
            isDense: true,
            hint: Text(
              initial ?? "",
              style: TextStyle(color: AppColors.kHintStyle),
            ),
            contentPadding: const EdgeInsets.only(bottom: 6),
            suffixIcon:
                suffix ??
                (valid
                    ? const Icon(
                        Icons.check_circle,
                        color: AppColors.primary,
                        size: 24,
                      )
                    : null),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.lineColor),
            ),
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _signupButton(BuildContext context) {
    return Center(
      child: Builder(
        builder: (context) {
          return BasicReactiveButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                if (!isCheck) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: AppColors.primary,
                      content: Text(
                        "Please accept the agree and terms",
                        style: TextStyle(color: AppColors.background),
                      ),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                  return;
                }
                UserCreationReq userCreationReq = UserCreationReq(
                  userName: _userNameCon.text,
                  email: _emailCon.text,
                  gender: context.read<GenderSelectionCubit>().selectedIndex,
                  password: _passwordCon.text,
                );
                context.read<ButtonStateCubit>().execute(
                  usecase: SignupUseCase(),
                  params: userCreationReq,
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
            title: 'Sign Up',
          );
        },
      ),
    );
  }
}
