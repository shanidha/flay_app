import 'package:flay_app/data/auth/repository/auth_repo_impl.dart';
import 'package:flay_app/domain/auth/repository/auth.dart';
import 'package:flay_app/domain/auth/usecases/signin.dart';
import 'package:flay_app/domain/auth/usecases/signup.dart';
import 'package:get_it/get_it.dart';

import 'data/auth/service/auth_firebase_service.dart';
import 'domain/auth/usecases/send_password_email.dart';

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
      sl.registerSingleton<SendPasswordResetEmailUseCase>(
    SendPasswordResetEmailUseCase()
  );

  

}
