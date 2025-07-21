import 'package:flay_app/core/configs/themes/app_colors.dart';
import 'package:flay_app/core/constants/app_fonts.dart';
import 'package:flutter/material.dart';

class BasicAppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final Widget? content;
  final double? height;
  final double? width;
  const BasicAppButton({
    required this.onPressed,
    this.title = '',
    this.height,
    this.width,
    this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(
          width ?? MediaQuery.of(context).size.width,
          height ?? 50,
        ),
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
