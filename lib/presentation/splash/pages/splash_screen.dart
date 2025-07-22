import 'package:flay_app/core/configs/assets/app_vectors.dart';
import 'package:flay_app/core/configs/themes/app_colors.dart';
import 'package:flay_app/presentation/home/pages/explore_screen.dart';
import 'package:flay_app/presentation/splash/bloc/splash_cubit.dart';
import 'package:flay_app/presentation/splash/bloc/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

 

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is UnAuthenticated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ExploreScreen()),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Center(child: SvgPicture.asset(AppVectors.splashLogo)),
      ),
    );
  }
}
