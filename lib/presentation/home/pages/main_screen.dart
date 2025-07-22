import 'package:flay_app/core/configs/assets/app_vectors.dart';
import 'package:flay_app/core/constants/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../auth/pages/login_screen.dart';
import '../../auth/pages/signup_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            // Centered SVG Image
            Center(
              child: SvgPicture.asset(AppVectors.mainScreenLogo,
                width: MediaQuery.of(context).size.width * 0.7,
              ),
            ),
            const Spacer(),
            // Bottom buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildButton(
                    context,
                    text: 'Login',isBorder: false,
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildButton(
                    context,isBorder: true,
                    text: 'Sign Up',
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SignupScreen()),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Reusable button 
  Widget _buildButton(
    BuildContext context, {
    required String text,
    required bool isBorder,
    required Color backgroundColor,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      height:55,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            side:isBorder? BorderSide(width: 2, color: Colors.white):BorderSide.none,
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 16,fontFamily: FontConstants.fontFamily,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}