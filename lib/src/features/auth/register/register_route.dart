import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/restClient/rest_client.dart';
import '../../../data/app_data.dart';
import '../../../repositories/user/user_repository.dart';
import '../../../repositories/user/user_repository_impl.dart';
import '../../../services/user_login/user_login_service.dart';
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
          Provider<AuthCubit>(
            create: (context) => AuthCubit(
              userLoginService: context.read<UserLoginService>(),
            ),
          ),
        ],
        child: const RegisterPage(),
      );
}
