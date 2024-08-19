import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/restClient/rest_client.dart';
import '../../../data/app_data.dart';
import '../../../repositories/user/user_repository.dart';
import '../../../repositories/user/user_repository_impl.dart';
import '../../../services/user_login/user_login_service.dart';
import '../../../services/user_login/user_login_service_impl.dart';
import '../../../services/user_register/user_register_service.dart';
import '../../../services/user_register/user_register_service_impl.dart';
import '../cubit/auth_cubit.dart';
import 'register_page.dart';

class RegisterRoute {
  RegisterRoute._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<UserRepository>(
            create: (context) => UserRepositoryImpl(
              restClient: context.read<RestClient>(),
              appData: context.read<AppData>(),
            ),
          ),
          Provider<UserLoginService>(
            create: (context) => UserLoginServiceImpl(
              userRepository: context.read<UserRepository>(),
              appData: context.read<AppData>(),
            ),
          ),
          Provider<UserRegisterService>(
            create: (context) => UserRegisterServiceImpl(
              userRepository: context.read<UserRepository>(),
              userLoginService: context.read<UserLoginService>(),
            ),
          ),
          Provider<AuthCubit>(
            create: (context) => AuthCubit(
              userRegisterService: context.read<UserRegisterService>(),
              userLoginService: context.read<UserLoginService>(),
            ),
          ),
        ],
        child: const RegisterPage(),
      );
}
