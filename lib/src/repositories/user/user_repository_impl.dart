import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:todo_challenge/src/models/user_model.dart';

import '../../core/exceptions/auth_exception.dart';
import '../../core/exceptions/repository_exception.dart';
import '../../core/fp/either.dart';
import '../../core/fp/nil.dart';
import '../../core/restClient/rest_client.dart';
import '../../data/app_data.dart';
import 'user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final RestClient restClient;
  final AppData appData;
  UserRepositoryImpl({required this.restClient, required this.appData});

  @override
  Future<Either<Exception, String>> login(String email, String password) async {
    try {
      final Response(:data) = await restClient.unAuth.post(
        '/auth',
        data: {
          'email': email,
          'password': password,
        },
      );

      return Success(data['access_token']);
    } on DioException catch (e, s) {
      if (e.response != null) {
        final Response(:statusCode) = e.response!;
        if (statusCode == HttpStatus.forbidden) {
          log('Login ou senha inválidos', error: e, stackTrace: s);
          return Failure(AuthUnauthorizedException());
        }
      }
      log('Erro ao realizar login', error: e, stackTrace: s);
      return Failure(AuthError(message: 'Erro ao realizar login'));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> register(
      ({String email, String name, String password}) userData) async {
    try {
      await restClient.unAuth.post(
        '/users',
        data: {
          'name': userData.name,
          'email': userData.email,
          'password': userData.password,
        },
      );
      return Success(nil);
    } on DioException catch (e, s) {
      log('Erro ao registrar usuário', error: e, stackTrace: s);
      return Failure(RepositoryException(message: 'Erro ao registrar usuário'));
    }
  }

  @override
  Future<Either<RepositoryException, UserModel>> getUser() async {
    try {
      final Response(:data) = await restClient.auth.get('/me');
      print(data);
      final user = UserModel.fromJson(data);
      return Success(user);
    } on DioException catch (e, s) {
      log('Erro ao buscar usuário', error: e, stackTrace: s);
      return Failure(RepositoryException(message: 'Erro ao buscar usuário'));
    }
  }
}
