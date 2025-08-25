import 'package:firebase_core/firebase_core.dart';
import 'package:flay_app/features/splash/presentation/bloc/splash_cubit.dart';
import 'package:flay_app/service_locator.dart' show initializeDependencies;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/configs/themes/app_themes.dart';
import 'features/splash/presentation/pages/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>SplashCubit()..appStarted(),
      child: MaterialApp(
        title: 'Flay',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.appTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
