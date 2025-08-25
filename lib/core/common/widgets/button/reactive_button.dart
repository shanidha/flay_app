import 'package:flay_app/core/configs/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/button/button_state.dart';
import '../../bloc/button/button_state_cubit.dart';

class BasicReactiveButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final bool isIconAdded;
  final Widget? icon;
  final double? height;
  final Widget? content;
  const BasicReactiveButton({
    required this.onPressed,
    this.isIconAdded = false,
    this.title = '',
    this.height,
    this.content,this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ButtonStateCubit, ButtonState>(
      builder: (context, state) {
        if (state is ButtonLoadingState) {
          return _loading();
        }
        return _initial();
      },
    );
  }

  Widget _loading() {
    return ElevatedButton(
      onPressed: null,
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(height ?? 50),
      ),
      child: Container(
        height: height ?? 50,
        alignment: Alignment.center,
        child: const CircularProgressIndicator(color: AppColors.primary),
      ),
    );
  }

  Widget _initial() {
    return isIconAdded
        ? SizedBox(
            width: double.infinity,
            height: 50,
            child: OutlinedButton.icon(
              onPressed: onPressed,
              icon: icon,
              label:  Text(
                title,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(color: Colors.black12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          )
        : ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(height ?? 50),
            ),
            child:
                content ??
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.background,
                    fontWeight: FontWeight.w400,
                  ),
                ),
          );
  }
}
