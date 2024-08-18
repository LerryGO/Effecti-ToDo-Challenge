part of 'auth_cubit.dart';

enum AuthStateStatus {
  initial,
  loading,
  loggedIn,
  loggedOut,
  error,
  success,
}

class AuthState extends Equatable {
  const AuthState({required this.status, this.errorMessage});

  const AuthState.initial()
      : status = AuthStateStatus.initial,
        errorMessage = null;

  final AuthStateStatus status;
  final String? errorMessage;

  @override
  List<Object?> get props => [status, errorMessage];
  AuthState copyWith({
    AuthStateStatus? status,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
