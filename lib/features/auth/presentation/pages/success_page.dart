import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/configs/assets/app_vectors.dart';
import '../../../../core/configs/themes/app_colors.dart';
import '../../../../core/constants/app_fonts.dart';

class SuccessPage extends StatelessWidget {
  final String message;
  final String title;
  final void Function(BuildContext) onPressed;
  const SuccessPage({
    super.key,
    required this.message,
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // —— SucessLogo
            Center(child: SvgPicture.asset(AppVectors.sucess, width: 80)),

            const SizedBox(height: 60),
            Text(
              message,
              style: TextStyle(fontSize: 20, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            _navigatorButton(context),
          ],
        ),
      ),
    );
  }

  Widget _navigatorButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(context),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(MediaQuery.of(context).size.width / 1.5, 50),
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 0,
      ),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: FontConstants.fontFamily,
          fontSize: 18,
          color: AppColors.background,
        ),
      ),
    );
  }
}
