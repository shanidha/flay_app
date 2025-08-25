import 'package:flay_app/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:flay_app/features/auth/domain/repository/auth_repository.dart';
import 'package:flay_app/features/auth/domain/usecases/signin.dart';
import 'package:flay_app/features/auth/domain/usecases/signin_google.dart';
import 'package:flay_app/features/auth/domain/usecases/signup.dart';
import 'package:get_it/get_it.dart';

import 'features/auth/data/datasources/auth_firebase_datasource.dart';
import 'features/auth/domain/usecases/send_password_email.dart';

final sl = GetIt.instance;
//Dependency INjection global instance singleton
Future<void> initializeDependencies() async {
  // Services
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());

  // Repositories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  // Usecases
  sl.registerSingleton<SignupUseCase>(SignupUseCase());
  sl.registerSingleton<SigninUsecase>(SigninUsecase());
   sl.registerSingleton<SignupWithGoogleUseCase>(SignupWithGoogleUseCase());
  sl.registerSingleton<SendPasswordResetEmailUseCase>(SendPasswordResetEmailUseCase());
}
