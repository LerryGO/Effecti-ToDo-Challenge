import 'package:shared_preferences/shared_preferences.dart';

import '../../core/exceptions/service_exception.dart';
import '../../core/fp/either.dart';
import '../../core/fp/nil.dart';
import '../../data/app_data.dart';
import 'user_logout_service.dart';

class UserLogoutServiceImpl implements UserLogoutService {
  final AppData _appData;

  UserLogoutServiceImpl({required AppData appData}) : _appData = appData;
  @override
  Future<Either<ServiceException, Nil>> logout() async {
    final sp = SharedPreferencesAsync();

    await sp.clear();
    _appData.user = null;

    return Success(nil);
  }
}
