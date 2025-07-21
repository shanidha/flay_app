import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


import '../../../common/widgets/button/reactive_button.dart';
import '../../../core/configs/assets/app_vectors.dart';

class SuccessPage extends StatelessWidget {
  final String message;
   final String title;
  final   VoidCallback onPressed;
  const SuccessPage({super.key, required this.message, required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // —— SucessLogo
            Center(
              child: SvgPicture.asset(
                AppVectors.sucess,
                width: MediaQuery.of(context).size.width * 0.7,
              ),
            ),

            const SizedBox(height: 8),
             Text(
            message,
              style: TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            _navigatorButton(context),
          ],
        ),
      ),
    );
  }

  Widget _navigatorButton(BuildContext context) {
    return Center(
      child: Builder(
        builder: (context) {
          return BasicReactiveButton(
            onPressed:onPressed,
            title: title,
          );
        },
      ),
    );
  }
}
