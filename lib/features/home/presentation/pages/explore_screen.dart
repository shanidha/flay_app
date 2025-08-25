import 'package:flay_app/core/configs/assets/app_images.dart';
import 'package:flay_app/features/home/presentation/pages/main_screen.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_fonts.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildBanner(AppImages.banner1, screenWidth, 0.05),
              _buildBanner(AppImages.banner2, screenWidth, 0.05),
              _buildBanner(AppImages.banner3, screenWidth, 0.05),
              _buildExploreButton(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Responsive image banner
  Widget _buildBanner(String assetPath, double screenWidth, double horizontalPadding) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * horizontalPadding,
        vertical: 20,
      ),
      child: Image.asset(
        assetPath,
        width: screenWidth * (1 - horizontalPadding* 2),
        fit: BoxFit.cover,
      ),
    );
  }

  ///  "Explore Now" button
  Widget _buildExploreButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MainScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
            elevation: 0,
          ),
          child: const Text(
            'Explore Now',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,fontFamily: FontConstants.fontFamily,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}